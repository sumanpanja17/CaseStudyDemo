
    namespace myEmployeeCaseStudy.sap.clm;
    using { cuid, sap.common.CodeList, managed } from '@sap/cds/common';
    using {myEmployeeCaseStudy.sap.clm.ProjectMaster}from './projectmaster';
    using {myEmployeeCaseStudy.sap.clm.LearingMaster} from './LearningMaster';
    using {myEmployeeCaseStudy.sap.clm.CourseContacts} from './LearningMaster';
    
    
    
    entity Employee : cuid, managed {


        // Naming convention camlecase ==> firstName 
        // Plurals for entities 
        // many bank details
        // tittle is not being used
        empid : String(15) @assert.unique @title : 'Employee ID';
        first_name   : String(20) @title : 'First Name' @mandatory;
        last_name    : String(20) @title : 'Last Name';
        date_joining : DateTime  ;
        end_date     : DateTime @title : 'End Date';
        email_id     : String(255) @mandatory @title : 'Mail ID';
        phone_number : String(10)  @title : 'Contact Number' @assert.format : '\+?[0-9]{10,15}';
        status       : Association to EmployeeStatus default '01' @title : 'Status';

        address      : String(1024);
        bankdetails  : Composition of many BankDetails on bankdetails.employee = $self;
        employeeProject : Composition of many EmployeeProject on employeeProject.employee = $self;
        employeeLearning : Composition of many Learing on employeeLearning.employee = $self;
        rating : Composition of many Rating on rating.employee = $self;
    }
    
    // Employee.Bankdetails Should be follwed if assotiation is there
    entity BankDetails : cuid, managed {
        account_number : String(10) @mandatory;
        bank_name      : String(255);

        employee       : Association to Employee;
    }

    entity EmployeeStatus : CodeList {
        key code : String(2) @title : 'Status';
            name : String(80) @title : 'Description';
            Criticality : Integer

    }

    entity EmployeeProject : cuid, managed {
        
        project: Association to ProjectMaster;
        employee: Association to Employee;
    } ;


    entity Learing : cuid, managed {
        
        employee : Association to Employee;
        learningmaster: Association to LearingMaster;
        status: String(02);

    }

    extend CourseContacts with {
        employee : Association to Employee;
    };

    // @assert.unique: {
    // uniqueYearPerEmployee: {
    //     fields  : [ year, employee ],
    //     message : 'Rating for this year already exists for this employee'
    //     }
    // }

    entity Rating : cuid, managed {
        year     : Date not null;
        rating   : Integer    @title: 'Rating';
        employee : Association to  Employee;
    };





