import cds, { data } from '@sap/cds';

module.exports = class projectsrv extends cds.ApplicationService {

    async init() {

        this.before('CREATE', 'ProjectMaster.drafts', async (req) => {
            const num = Math.floor(Math.random() * 9) + 10;
            req.data.projId = `ACE${num}`;
        });

        this.before('DELETE', 'ProjectMaster', async(req)=>{
    
                let{ ID } = req.data;
    
                //check if learning is assigned 
                let transx = cds.transaction(req);
                //let { Learning } = cds.entities('myEmployeeCaseStudy.sap.clm');
    
                let employeesrv = await cds.connect.to('mydemosrv');
    
                let isassigned = await employeesrv.run(
                    SELECT.one
                        .from('EmployeeProject')
                        .where({ project_ID: ID })
                )
    
                if(isassigned){
                    req.error(
                        {
                            code : 400,
                            message: `Cannot delete — this Project is assigned to employee(s).`,
                            target: 'course_description'
    
                        }
                    )
                }
    } )

        return super.init();
    }
    
}