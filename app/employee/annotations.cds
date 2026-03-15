    using mydemosrv as service from '../../srv/EmployeeService';

    annotate service.Employee with @(

        UI.UpdateHidden : ( status.code = '04'),
        UI.DeleteHidden : ( status.code != '04' ),
        
        UI.DataPoint #status: {
            Value       : status_code,
            Title       : 'Status',
            Criticality : status.Criticality 
        },

        UI.HeaderInfo: {
            TypeName: 'Employee',
            TypeNamePlural: 'Employees',
            Title : {
                $Type : 'UI.DataField',
                Value : empid,
            },
            Description:{
                $Type: 'UI.DataField',
                Value: full_name,
            }

        },

        UI.SelectionFields: [
            status_code 
        ],

        UI.FieldGroup #EmployeeLeft: {
            $Type: 'UI.FieldGroupType',
            Data: [
                { $Type:'UI.DataField', Label:'First Name',   Value:first_name,   @HTML5.CssDefaults:{width:'auto'} },
                { $Type:'UI.DataField', Label:'Joining Date', Value:date_joining, @HTML5.CssDefaults:{width:'auto'} },
                { $Type:'UI.DataField', Label:'Last Name',    Value:last_name,    @HTML5.CssDefaults:{width:'auto'} },
                { $Type:'UI.DataField', Label:'End Date',     Value:end_date,     @HTML5.CssDefaults:{width:'auto'} },
                { $Type:'UI.DataFieldForAnnotation', Label:'Status',     
                   Value:status_code, Target:@UI.DataPoint#status ,@HTML5.CssDefaults:{width:'auto'}},
                
            ]
        },

        UI.FieldGroup #EmployeeRight: {
            $Type: 'UI.FieldGroupType',
            Data: [
                { $Type:'UI.DataField', Label:'Email',        Value:email_id     ,@HTML5.CssDefaults:{width:'auto'}},
                { $Type:'UI.DataField', Label:'Mobile Number', Value:phone_number ,@HTML5.CssDefaults:{width:'auto'}},
            ]
        },


        UI.Facets: [
            {
                $Type  : 'UI.CollectionFacet',
                ID     : 'GeneralInfo',
                Label  : 'General Information',
                Facets : [
                            {
                                $Type  : 'UI.ReferenceFacet',
                                ID     : 'EmployeeLeft',
                                Target : '@UI.FieldGroup#EmployeeLeft'
                            },
                            {
                                $Type  : 'UI.ReferenceFacet',
                                ID     : 'EmployeeRight',
                                Target : '@UI.FieldGroup#EmployeeRight'
                            }
                    ]
            },
            {
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Address',
                Target : '@UI.FieldGroup#AddressGroup'
            },
            {
               
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Banks',
                Target : 'bankdetails/@UI.LineItem',
            },
                   
            {
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Projects',  
                Target : 'employeeProject/@UI.LineItem'
                
            },
            {
        
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Learnings',  
                Target : 'employeeLearning/@UI.LineItem'
            
            },
            {
                $Type  : 'UI.ReferenceFacet',
                Label  : 'Ratings',
                Target : 'rating/@UI.LineItem'
            },
        ],

        UI.LineItem: [

            {
                $Type: 'UI.DataFieldForCreate',
                Label: 'New',
                action : 'Entity/Create'

            },
            { 
                $Type:'UI.DataField', 
                Label:'ID',   
                Value:empid, 
                @HTML5.CssDefaults:{width:'auto'} 
            },
            { 
                $Type:'UI.DataField', 
                Label:'First Name',   
                Value:first_name, 
                @HTML5.CssDefaults:{width:'auto'} 
            },
            { 
                $Type:'UI.DataField', 
                Label:'Last Name',   
                 Value:last_name,   
                 @HTML5.CssDefaults:{width:'auto'} 
            },
            { 
                $Type:'UI.DataField', 
                Label:'Joining Date', 
                Value:date_joining, 
                @HTML5.CssDefaults:{width:'auto'} 
                
            },
            { 
                $Type:'UI.DataField', 
                Label:'End Date',     
                Value:end_date, 
                @HTML5.CssDefaults:{width:'auto'}    
            },
            { 
                $Type:'UI.DataFieldForAnnotation', 
                Label:'Status',       
                Value:status_code, 
                Target:@UI.DataPoint#status, 
                @HTML5.CssDefaults:{width:'auto'} 
            },
            { 
                $Type:'UI.DataField', 
                Label:'Email',        
                Value:email_id, 
                @HTML5.CssDefaults:{width:'auto'}     
            }
        ],
        UI.Identification : [
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'mydemosrv.Hire',
                Label  : 'Hire',    
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'mydemosrv.SettoObsolete',
                Label : 'Obsolete',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'mydemosrv.UnderNotice',
                Label : 'Under Notice',
            },
        ],
        );

    annotate service.Employee with @(
        UI.FieldGroup #AddressGroup: {
            $Type: 'UI.FieldGroupType',
            Data: [
            { $Type:'UI.DataField',  Value:address },
            ]
        }
    );

    annotate service.Rating with @(

        UI.DataPoint #Rating: {
            Value       : rating,
            TargetValue : 5,
            Visualization : #Rating
        },


        UI.LineItem: [
                //{ $Type:'UI.DataField', Label:'Rating',         Value:rating, @UI.Hidden: true },
                { $Type:'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#Rating', Label:'Rating' ,@HTML5.CssDefaults:{width:'auto'}},
                { $Type:'UI.DataField', Label:'Year', Value: year ,@HTML5.CssDefaults:{width:'auto'}}
            ],

       UI.CreateHidden : ( employee.status.code = '01' OR employee.status.code = '03' ),
       UI.DeleteHidden : ( employee.status.code = '01' OR employee.status.code = '03' ),
        
    );

    annotate service.BankDetails with @(
        UI.LineItem: [
            { $Type:'UI.DataField', Label:'Bank Name',       Value:bank_name, @HTML5.CssDefaults:{width:'auto'}      },
            { $Type:'UI.DataField', Label:'Account Number',  Value:account_number, @HTML5.CssDefaults:{width:'auto'} }
        ],

        UI.CreateHidden : ( employee.status.code = '01' OR employee.status.code = '03' ),
    );

    annotate service.EmployeeProject with @(

        UI.LineItem:[
            {
                $Type : 'UI.DataField', 
                Value: project_ID, 
                Label: 'Project ID',
                @HTML5.CssDefaults:{width:'auto'} 
                
            },
            {
                $Type : 'UI.DataField', 
                Value: project.name, 
                Label: 'Project Name',
                @HTML5.CssDefaults:{width:'auto'} 
            }
        ],

        UI.CreateHidden : ( employee.status.code = '01' OR employee.status.code = '03' ),
    ) ;

    annotate service.Learing with @(
    
         UI.LineItem:[
            {
                $Type : 'UI.DataField', 
                Value: learningmaster_ID, 
                Label: 'Learning ID',
                @HTML5.CssDefaults:{width:'auto'} 
                
            },
            {
                $Type : 'UI.DataField', 
                Value: learningmaster.course_description, 
                Label: 'Course Description',
                @HTML5.CssDefaults:{width:'auto'} 
            }
        ],

        UI.CreateHidden : ( employee.status.code = '01' OR employee.status.code = '03' ),
    
    );
    
    
   annotate service.EmployeeProject with {  

    project @Common.Text            : project.projId 
            @Common.TextArrangement : #TextOnly 
            @Common.ValueList: {
                    CollectionPath : 'ProjectMaster',
                    Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterOut',
                        LocalDataProperty : project_ID,   
                        ValueListProperty : 'ID'
                    },
                    {
                        $Type             : 'Common.ValueListParameterIn',
                        LocalDataProperty : project_ID, 
                        ValueListProperty : 'projId'     
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'     
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'description' 
                    }
                ]
            }
            @Common.ValueListWithFixedValues: false;
        };

    annotate service.Learing with {  

        learningmaster @Common.Text            : learningmaster.courseid
                       @Common.TextArrangement : #TextOnly 
                       @Common.ValueList: {
                                CollectionPath : 'LearingMaster',
                                Parameters     : [
                                {
                                    $Type             : 'Common.ValueListParameterOut',
                                    LocalDataProperty : learningmaster_ID,   
                                    ValueListProperty : 'ID'
                                },
                                {
                                    $Type             : 'Common.ValueListParameterIn',
                                    LocalDataProperty : learningmaster_ID, 
                                    ValueListProperty : 'courseid'     
                                },
                                {
                                    $Type             : 'Common.ValueListParameterDisplayOnly',
                                    ValueListProperty : 'course_description'     
                                },
                            ]
                        }
                @Common.ValueListWithFixedValues: false;
        };

    annotate service.Employee with {
        status @Common.Text: status.name
               @Common.TextArrangement: #TextOnly
               @readonly;

        date_joining @readonly;
        end_date @readonly;
        address @UI.MultiLineText;
    };  

    annotate service.Employee actions {
        Hire @Core.OperationAvailable: isInPreparation
                @Common.SideEffects: {
                TargetEntities  : [$self],
                TargetProperties: [
                    'status_code', 'status',
                    'date_joining', 'end_date',
                    'isInPreparation', 'isHired', 'isUnderNotice'
                    ]
            };

        UnderNotice @Core.OperationAvailable: isHired
                    @Common.SideEffects: {
                    TargetEntities  : [$self],
                    TargetProperties: [
                        'status_code', 'status',
                        'end_date',
                        'isInPreparation', 'isHired', 'isUnderNotice',
                        'employeeLearning'
                        ]
                };

        SettoObsolete @Core.OperationAvailable: isUnderNotice
                        @Common.SideEffects: {
                        TargetEntities  : [$self],
                        TargetProperties: [
                            'status_code', 'status',
                            'isInPreparation', 'isHired', 'isUnderNotice'
                            ]
                    };

        
    };

    