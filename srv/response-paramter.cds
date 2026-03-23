using myEmployeeCaseStudy.sap.clm as clm from '../db/response-paramter';

service raponseParameter {

    @(odata.draft.enabled)
    entity ReponseParameters as projection on clm.ReponseParameters;
    entity status as projection on clm.ReponseParameters.Status;

}