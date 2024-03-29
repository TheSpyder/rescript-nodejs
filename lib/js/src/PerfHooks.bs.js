// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Nodeperf_hooks = require("node:perf_hooks");
var Js_null_undefined = require("rescript/lib/js/js_null_undefined.js");

var $$PerformanceEntry = {};

var PerformanceNodeTiming = {};

var $$Performance = {};

var Histogram = {};

function getEntriesByName(entryList, type_, name) {
  return entryList.getEntriesByName(name, Js_null_undefined.fromOption(type_));
}

var $$PerformanceObserverEntryList = {
  getEntriesByName: getEntriesByName
};

var $$PerformanceObserver = {};

function monitorEventLoopDelay(resolution, param) {
  return Nodeperf_hooks.eventLoopDelay(Js_null_undefined.fromOption(resolution));
}

exports.$$PerformanceEntry = $$PerformanceEntry;
exports.PerformanceNodeTiming = PerformanceNodeTiming;
exports.$$Performance = $$Performance;
exports.Histogram = Histogram;
exports.$$PerformanceObserverEntryList = $$PerformanceObserverEntryList;
exports.$$PerformanceObserver = $$PerformanceObserver;
exports.monitorEventLoopDelay = monitorEventLoopDelay;
/* node:perf_hooks Not a pure module */
