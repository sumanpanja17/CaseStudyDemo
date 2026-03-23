using raponseParameter as service from '../../srv/response-paramter';
using from '../../db/response-paramter';

annotate service.ReponseParameters with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : sequenceId,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'status_code',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : sequenceId,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status_code,
            Criticality : status.Criticality,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
    ],
);

annotate service.ReponseParameters with {

    status @(
        Common.Text : status.code,
        Common.TextArrangement : #TextOnly
    );

};



