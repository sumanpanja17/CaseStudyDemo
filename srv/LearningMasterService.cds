using myEmployeeCaseStudy.sap.clm as clm from '../db/LearningMaster';

service leanringsrv {

    @odata.draft.enabled
    entity learningmaster as projection on clm.LearingMaster;
    @readonly
    entity Employee as projection on clm.Employee;
    @readonly
    entity Learning as projection on clm.Learing;
    entity CourseContacts as projection on clm.CourseContacts;
    
}