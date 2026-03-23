  namespace myEmployeeCaseStudy.sap.clm;

using {  
    cuid,
    managed,
    sap.common.CodeList

} from '@sap/cds/common';


  entity ReponseParameters : cuid, managed {
    
    sequenceId : String(23);
    name : String(100) @mandatory;
    status : Association to ReponseParameters.Status;
    description : String;

  }

 
entity ReponseParameters.Status : CodeList {
    key code : Status;
    criticality : Criticality;
}

type Status : String(20) enum {
    inPreparation = '01';
    active        = '02';
    obsolete      = '03';
}

type Criticality : Integer enum {
    inPreparation = 1;
    active        = 2;
    obsolete      = 3;
}