sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"learning/test/integration/pages/learningmasterList",
	"learning/test/integration/pages/learningmasterObjectPage"
], function (JourneyRunner, learningmasterList, learningmasterObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('learning') + '/test/flp.html#app-preview',
        pages: {
			onThelearningmasterList: learningmasterList,
			onThelearningmasterObjectPage: learningmasterObjectPage
        },
        async: true
    });

    return runner;
});

