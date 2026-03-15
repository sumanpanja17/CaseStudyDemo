using projectsrv as service from '../../srv/ProjectService';
using from '../../db/schema';

annotate service.ProjectMaster with @(
    
    UI.HeaderInfo: {
            TypeName: 'Project',
            TypeNamePlural: 'Projects',
            Title : {
                $Type : 'UI.DataField',
                Value : name,
            },
            Description:{
                $Type: 'UI.DataField',
                Value: projId,
            }

        },

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : projId,
                 @HTML5.CssDefaults:{width:'auto'} 
            },
            {
                $Type : 'UI.DataField',
                Value : name,
                 @HTML5.CssDefaults:{width:'auto'} 
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID :   'ProjectDesc',
            Label : 'Projet Details',
            Target : '@UI.FieldGroup#ProjectDescGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : projId,
             @HTML5.CssDefaults:{width:'auto'} 
        },
        {
            $Type : 'UI.DataField',
            Value : name,
             @HTML5.CssDefaults:{width:'auto'} 
        },
        {
            $Type : 'UI.DataField',
            Value : description,
             @HTML5.CssDefaults:{width:'auto'} 
        },
    ],
);

annotate projectsrv.ProjectMaster with @(

     UI.FieldGroup #ProjectDescGroup: {
            $Type: 'UI.FieldGroupType',
            Data: [
            { $Type:'UI.DataField',  Value:description },
            ]
        }
    
);

annotate projectsrv.ProjectMaster with {
    description @UI.MultiLineText
};


annotate service.EmployeeProject with @(
    UI.LineItem #Demo : [
    ]
);

