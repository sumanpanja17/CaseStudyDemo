namespace myEmployeeCaseStudy.sap.clm;
using { cuid, managed } from '@sap/cds/common';
using {myEmployeeCaseStudy.sap.clm.Learing} from './schema';


entity LearingMaster : cuid , managed {

    courseid: String(12) @readonly @assert.unquie @title : 'ID';
    course_description : String(20) @title : 'Course Description' @mandatory;
    availability : Boolean @title : 'Availability';
    initial : Boolean @title : 'Onboarding course';
    Learning: Association to Learing;
    coures : Composition of many CourseContacts on coures.learningmaster = $self;
    
}

entity CourseContacts : cuid ,managed {
    learningmaster : Association to LearingMaster;
}