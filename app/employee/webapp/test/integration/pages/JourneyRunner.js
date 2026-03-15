sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"employee/test/integration/pages/EmployeeList",
	"employee/test/integration/pages/EmployeeObjectPage"
], function (JourneyRunner, EmployeeList, EmployeeObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('employee') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeeList: EmployeeList,
			onTheEmployeeObjectPage: EmployeeObjectPage
        },
        async: true
    });

    return runner;
});

