/*!
 * remark (http://getbootstrapadmin.com/remark)
 * Copyright 2016 amazingsurge
 * Licensed under the Themeforest Standard Licenses
 */

$.components.register("ladda",{mode:"init",defaults:{timeout:2e3},init:function(){if("undefined"!=typeof Ladda){var defaults=$.components.getDefaults("ladda");Ladda.bind('[data-plugin="ladda"]',defaults)}}}),$.components.register("laddaProgress",{mode:"init",defaults:{init:function(instance){var progress=0,interval=setInterval(function(){progress=Math.min(progress+.1*Math.random(),1),instance.setProgress(progress),1===progress&&(instance.stop(),clearInterval(interval))},200)}},init:function(){if("undefined"!=typeof Ladda){var defaults=$.components.getDefaults("laddaProgress");Ladda.bind('[data-plugin="laddaProgress"]',defaults)}}});