/*
 * Bulk URL Opener
 * Copyright (C) 2013, Melanto Ltd.
 * www.melanto.com 
 *
 */

	// default cleaner Settings
	if (!window.localStorage.appSettings) {
		window.localStorage.appSettings = JSON.stringify({ 
		"newTab": true, 
			"dedicatedWindow": false, 
		"newWindow": false, 
		"xPerWindow": false,
		"xNum": "10",
		"maxTotal": false,
		"xNumTotal": "25" ,
		"saveList": false,
		"cleanOpened": false,
		"autoClose": false    
		});
	}
	// app version
	var currVersion = getVersion();
	var prevVersion = window.localStorage.appVersion;
	if (currVersion != prevVersion) {
		if (typeof prevVersion == 'undefined') {
			onInstall();
		} else {
			onUpdate();
		}
		window.localStorage.appVersion = currVersion;
	}

// Check if this is new version
function onInstall() {
	
	if (navigator.onLine) {
		chrome.tabs.create({url: 'http://melanto.com/apps/bulk-url-opener/postinstall-chrome.html'});
	}
}
function onUpdate() {
	
	if (navigator.onLine) {
		//chrome.tabs.create({url: 'http://melanto.com/apps/bulk-url-opener/update-chrome.html'});
	}
}
function getVersion() {
	var details = chrome.app.getDetails();
	return details.version;
}