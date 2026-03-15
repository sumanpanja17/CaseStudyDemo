sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project/test/integration/pages/ProjectMasterList",
	"project/test/integration/pages/ProjectMasterObjectPage",
	"project/test/integration/pages/EmployeeProjectObjectPage"
], function (JourneyRunner, ProjectMasterList, ProjectMasterObjectPage, EmployeeProjectObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project') + '/test/flp.html#app-preview',
        pages: {
			onTheProjectMasterList: ProjectMasterList,
			onTheProjectMasterObjectPage: ProjectMasterObjectPage,
			onTheEmployeeProjectObjectPage: EmployeeProjectObjectPage
        },
        async: true
    });

    return runner;
});

