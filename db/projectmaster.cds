
    namespace myEmployeeCaseStudy.sap.clm;
    using { cuid, managed } from '@sap/cds/common';
    using { myEmployeeCaseStudy.sap.clm.EmployeeProject } from './schema';
    

    entity ProjectMaster : cuid, managed {
        employeeproject : Association to many EmployeeProject on employeeproject.project = $self;
        projId : String(15) @assert.unique @title : 'Project ID';
        name: String(15) @title : 'Name';
        description : String(255) @title : 'Project Details';
    }