using leanringsrv as service from '../../srv/LearningMasterService';

annotate service.learningmaster with @(

     
    UI.HeaderInfo: {
        TypeName       : 'Learning',
        TypeNamePlural : 'Learnings',
        Title          : { $Type: 'UI.DataField', Value: course_description }
    },

    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data: [
            { $Type: 'UI.DataField', Value: courseid,   @HTML5.CssDefaults: { width: 'auto' }},
            { $Type: 'UI.DataField', Value: course_description,   @HTML5.CssDefaults: { width: 'auto' }},
            { $Type: 'UI.DataField', Value: availability,        @HTML5.CssDefaults: { width: 'auto' } },
            { $Type: 'UI.DataField', Value: initial,  @HTML5.CssDefaults: { width: 'auto' }            }
        ]
    },

    UI.Facets: [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet1',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'CourseContacts',         
            Label  : 'Course Contacts',
            Target : 'coures/@UI.LineItem' 
        }
    ],

    UI.LineItem: [
        { $Type: 'UI.DataField', Value: courseid,   @HTML5.CssDefaults: { width: 'auto' }},
        { $Type: 'UI.DataField', Value: course_description,  @HTML5.CssDefaults: { width: 'auto' } },
        { $Type: 'UI.DataField', Value: availability,  @HTML5.CssDefaults: { width: 'auto' }      },
        { $Type: 'UI.DataField', Value: initial ,  @HTML5.CssDefaults: { width: 'auto' }           }
    ]
);

annotate service.CourseContacts with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : employee_ID,        
            Label : 'Employee',
            @HTML5.CssDefaults: { width: 'auto' }
        },
        {
            $Type : 'UI.DataField',
            Value : employee.first_name,        
            Label : 'Name',
            @HTML5.CssDefaults: { width: 'auto' }
        },
        {
            $Type : 'UI.DataField',
            Value : employee.email_id,        
            Label : 'Mail Address',
            @HTML5.CssDefaults: { width: 'auto' }
        },
        {
            $Type : 'UI.DataField',
            Value : employee.phone_number,        
            Label : 'Contact Number',
            @HTML5.CssDefaults: { width: 'auto' }
        }
    ]
);

annotate service.CourseContacts with {
    employee @Common.Text            : employee.empid 
             @Common.TextArrangement : #TextOnly
             @Common.ValueList: {
                 CollectionPath : 'Employee',
                 Parameters     : [
                     {
                         $Type             : 'Common.ValueListParameterOut',
                         LocalDataProperty : employee_ID,  
                         ValueListProperty : 'ID'
                     },
                     {
                         $Type             : 'Common.ValueListParameterDisplayOnly',
                         ValueListProperty : 'empid',
                         Text : 'Employee ID'
                     },
                     {
                         $Type             : 'Common.ValueListParameterDisplayOnly',
                         ValueListProperty : 'first_name',
                         Text : 'First Name'
                     },
                     {
                         $Type             : 'Common.ValueListParameterDisplayOnly',
                         ValueListProperty : 'email_id',
                         Text: 'Mail ID'
                     }
                 ]
             }
             @Common.ValueListWithFixedValues: false;
};