using myEmployeeCaseStudy.sap.clm as clm from '../db/projectmaster';

service projectsrv {

    @odata.draft.enabled
    entity ProjectMaster as projection on clm.ProjectMaster;
    
}