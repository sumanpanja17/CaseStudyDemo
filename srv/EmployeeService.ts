import cds, { data } from '@sap/cds';
import crypto from 'crypto';
import { stat } from 'fs';
import { enableCompileCache } from 'module';

module.exports = class MyDemoSrv extends cds.ApplicationService {

    async init() {

        const setVirtualFields = async (employees: any[], isDraft: boolean) => {
            if (!Array.isArray(employees)) employees = [employees];

            for (const emp of employees) {
                if (!emp || !emp.ID) continue;

                let statusCode = emp.status_code;

                if (statusCode === undefined) {
                    const table = isDraft ? 'mydemosrv.Employee.drafts' : 'mydemosrv.Employee';
                    //check ?? can be made outside=>perfornce"
                    const record = await SELECT.one
                                    .from(table)
                                    .columns('status_code')
                                    .where({ ID: emp.ID });
                    statusCode = record?.status_code;
                }

                emp.isInPreparation = !isDraft && statusCode === '01';
                emp.isHired = !isDraft && statusCode === '02';
                emp.isUnderNotice = !isDraft && statusCode === '03';
            }
        };

        this.after('READ', 'Employee',        async (employees: any[]) => setVirtualFields(employees, false));
        //this.after('READ', 'Employee.drafts', async (employees: any[]) => setVirtualFields(employees, true));


        const updatestartdate = async (startdate: String, id : string, isDraft: Boolean)=>{

            const table = isDraft ? 'mydemosrv.Employee.drafts' : 'mydemosrv.Employee';
            const isupdated = await UPDATE(table).set({date_joining: startdate}).where({ID : id});
            if (isupdated === 0){
                 return null;
            }else{
                return 1;
            }

        };

        const updateendate = async (enddate: String, id: String, isDraft : boolean)=>{
            const table = isDraft ? 'mydemosrv.Employee.drafts' : 'mydemosrv.Employee';
            const isupdated = await UPDATE(table).set({end_date: enddate}).where({ID: id});
             if (isupdated === 0){
                 return null;
            }else{
                return 1;
            }
        };

        const adddeafultlearning = async (id: string, IsActiveEntity: boolean)=>{

            const learningSrv = await cds.connect.to('leanringsrv');
            const defaultCourses = await learningSrv.run(
                SELECT.from('leanringsrv.learningmaster')
                    .where({ initial: true, IsActiveEntity: true })
            );

            if (!defaultCourses || defaultCourses.length === 0) {
                console.log('No default courses found');
                return;
            }

            const { Learing } = cds.entities('myEmployeeCaseStudy.sap.clm');

            const learningentries = defaultCourses.map((course: any) => ({
                ID               : cds.utils.uuid(),  
                employee_ID      : id,
                learningmaster_ID: course.ID,
                status           : '01'
            }));

            console.log('learningentries:', JSON.stringify(learningentries));

            try {
                await cds.db.run(INSERT.into(Learing).entries(learningentries));
            } catch(err: any) {
                console.log('Insert ERROR:', err.message);
            }

            const check = await cds.db.run(
                SELECT.from(Learing).where({ employee_ID: id })
            );

        };  

        // Can be handled in CDS entity with assert//
        const validatename = async(name : string)=>{
            const regex = /^[A-Za-z ]+$/;
            if (!name){
                return false;
            } 

             if (name && !regex.test(name)) {
                return false;
            }
            return true;
        };
        
        const duplicateAcctNo = async(req : cds.Request)=>{
            
            const { ID } = req.data;
            const tanscx = cds.transaction(req);  // CDS Trasaction => not required for select query

            const dbbank = await tanscx.run(
                                        SELECT.one.from('mydemosrv.BankDetails.drafts').
                                        columns('bank_name','account_number').
                                        where({employee_ID:ID})
            ) 

            if(dbbank == undefined){
                 return false;
            };      

            const duplacctno = await tanscx.run(
                SELECT.one.from('mydemosrv.BankDetails').
                where({account_number :dbbank.account_number, bank_name :dbbank.bank_name}).
                and({employee_ID: {'!=': ID}})
            )

           if (duplacctno) { 
            const emp = await tanscx.run(
                                    SELECT.one.from('mydemosrv.Employee')
                                        .columns('empid', 'first_name', 'last_name')
                                        .where({ ID: duplacctno.employee_ID })
                                    );

            return `Duplicate account number found in Employee ${emp?.empid} - ${emp?.first_name} ${emp?.last_name}`;
            };
            
           return false;

        };

        const validatemailid = async(MailID : string)=>{

            if (!MailID) {
                return false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailRegex.test(MailID)) {
                return false;
            }
            return true;
        }

       
        const updateStatus = async (req: cds.Request, status: string, isDraft: boolean) => {

            const { ID } = req.params[0] as { ID: string };
            const isActive   = (req.params[0] as any).IsActiveEntity;

            const table = isDraft ? 'mydemosrv.Employee.drafts' : 'mydemosrv.Employee';

            // const employee = await SELECT.one
            //     .from(table)
            //     .columns('ID', 'status', 'first_name', 'last_name')
            //     .where({ ID });

            // if (!employee) {
            //     return req.reject(404, `Employee with ID "${ID}" not found.`);
            // }

            // if (employee.status === status) {
            //     return req.reject(
            //         400,
            //         `Employee "${employee.first_name} ${employee.last_name}" is already in this status.`
            //     );
            // }

            // Separate DB related activites in separe class
            const isupdated = await UPDATE(table)
                                    .set({ status_code: status })
                                    .where({ ID });

            if (isupdated > 0){

           // Update start date to currecnt date
            console.log('req.data:', JSON.stringify(req.data));
            console.log('req.params:', JSON.stringify(req.params));
              
              if (status == '02') {
                // Camelcase
                updatestartdate(new Date().toISOString(), ID, isDraft)
                updateendate(new Date(9999, 12, 31, 23, 59, 59).toISOString(), ID, isDraft)
                adddeafultlearning(ID,isActive);
              }else if (status == '03'){
                let now = new Date( );
                let twoMonthsLater = now.setMonth(now.getMonth( ) + 2);
                updateendate(now.toISOString(), ID, isDraft)
              }
               
            }

            return null;
            };


        // Auto Generate Employee ID ==> ? number range //
        this.before('CREATE', 'Employee.drafts', async(req)=>{
            const num = Math.floor(Math.random() * 9) + 10;
            req.data.empid = `ACE${num}`;

        })

        // validations //

        this.before(['CREATE', 'UPDATE'], 'Employee', async (req) => {
            const { first_name, last_name } = req.data;
            let isvalid = await validatename(first_name);
            if ( isvalid  == false){
              req.error({
                code : 400, 
                message : 'Invalid First Name',
                target: first_name,
                status : 400
            });
            }

            isvalid = await validatename(last_name);
            if (!isvalid){
              req.error({
                code : 400, 
                message : 'Invalid Last Name',
                target: first_name,
                status : 400
            });
            }
        });


        this.before('SAVE', 'Employee', async (req) => {
            let err = await duplicateAcctNo(req);
            if (err) {
                req.error({
                    code: 400,
                    message: err,
                    target: 'account_number'
                    });
                    }
                });

        this.before(['CREATE', 'UPDATE'], 'Employee', async(req)=>{

            const { email_id } = req.data;
            let isvalidmail = await validatemailid(email_id);
            if(isvalidmail == false){
                req.error({
                code : 400, 
                message : 'Invalid Mail ID',
                target: email_id
            });
            }
        })


        // Actions //
        // Better to use enum --> In CDS 

        this.on('Hire', 'Employee',        (req) => updateStatus(req, '02', false));
        this.on('Hire', 'Employee.drafts', (req) => updateStatus(req, '02', true));

        this.on('UnderNotice', 'Employee',        (req) => updateStatus(req, '03', false));
        this.on('UnderNotice', 'Employee.drafts', (req) => updateStatus(req, '03', true));

        this.on('SettoObsolete', 'Employee',        (req) => updateStatus(req, '04', false));
        this.on('SettoObsolete', 'Employee.drafts', (req) => updateStatus(req, '04', true));     


        this.before(['UPDATE', 'CREATE'], 'Rating.drafts', async (req) => {

            //console.log('NEW Rating.drafts fired', JSON.stringify(req.data));

            const { year, employee_ID } = req.data;
            if (!year || !employee_ID) return;

            let yearOnly = new Date(year).getFullYear();

            let existing = await SELECT.one
                                       .from('mydemosrv.rating.drafts')
                                       .where({ employee_ID });

            let arrexisting = Array.isArray(existing) ? existing : [existing].filter(Boolean);

            let isinsameyr = arrexisting.find((line: any)=>
                                new Date(line.year).getFullYear() === yearOnly
                             );

            if (isinsameyr && isinsameyr.ID !== req.data.ID ) {
                req.error({
                    code   : 400,
                    message: `Rating for year ${yearOnly} already exists for this employee.`,
                    target : 'year'
                });
            }
        });


        return super.init();
    }

}