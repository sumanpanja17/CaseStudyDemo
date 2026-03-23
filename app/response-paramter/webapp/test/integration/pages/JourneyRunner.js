sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"responseparamter/test/integration/pages/ReponseParametersList",
	"responseparamter/test/integration/pages/ReponseParametersObjectPage"
], function (JourneyRunner, ReponseParametersList, ReponseParametersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('responseparamter') + '/test/flp.html#app-preview',
        pages: {
			onTheReponseParametersList: ReponseParametersList,
			onTheReponseParametersObjectPage: ReponseParametersObjectPage
        },
        async: true
    });

    return runner;
});

