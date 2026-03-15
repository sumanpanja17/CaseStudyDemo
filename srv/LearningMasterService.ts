import cds, { data } from '@sap/cds';

module.exports = class leanringsrv extends cds.ApplicationService {

    async init() {

        this.before('CREATE', 'learningmaster.drafts', async (req) => {
            console.log('Testing DRAFT CREATE triggered');
            const num = Math.floor(Math.random() * 9) + 10;
            req.data.courseid = `ACE${num}`;
        });

        this.before('DELETE', 'learningmaster', async(req)=>{

            let{ ID } = req.data;

            //check if learning is assigned 
            let transx = cds.transaction(req);
            //let { Learning } = cds.entities('myEmployeeCaseStudy.sap.clm');

            let employeesrv = await cds.connect.to('mydemosrv');

            let isassigned = await employeesrv.run(
                SELECT.one
                    .from('Learing')
                    .where({ learningmaster_ID: ID })
            )

            if(isassigned){
                req.error(
                    {
                        code : 400,
                        message: `Cannot delete — this course is assigned to employee(s).`,
                        target: 'course_description'

                    }
                )
            }
           
        } )

        return super.init();
    }
}