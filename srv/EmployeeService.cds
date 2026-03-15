using myEmployeeCaseStudy.sap.clm as clm from '../db/schema';

service mydemosrv {

    @(odata.draft.enabled)
    entity Employee as projection on clm.Employee{
        *,
       virtual null as isInPreparation: Boolean,
       virtual null as isHired: Boolean,
       virtual null as isUnderNotice: Boolean,
       first_name || ' ' || last_name as full_name: String

    }
        actions{
            action Hire(); // cameclase 
            actION UnderNotice();
            action SettoObsolete()
            
        }; 

    entity BankDetails as projection on clm.BankDetails;
    entity EmployeeStatus as projection on clm.EmployeeStatus;
    entity EmployeeProject as projection on clm.EmployeeProject;
    entity Learing as projection on clm.Learing;
    entity Rating as projection on clm.Rating;

    @readonly                                   
    entity ProjectMaster as projection on clm.ProjectMaster;

    @readonly
    entity LearingMaster as projection on clm.LearingMaster;

}
