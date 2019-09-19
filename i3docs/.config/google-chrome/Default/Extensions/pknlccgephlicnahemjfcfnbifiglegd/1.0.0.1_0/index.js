/*
 * Bulk URL Opener
 * Copyright (C) 2013, Melanto Ltd.
 * www.melanto.com 
 *
 */
 
function loadSettings(){
	// default app settings if no settings stored yet:
	if (!window.localStorage.appSettings) {
		window.localStorage.appSettings = JSON.stringify({ 
		"newTab": true, 
			"dedicatedWindow": false, 
		"newWindow": false, 
		"xPerWindow": false,
		"xNum": "10",
		"maxTotal": false,
		"xNumTotal": "25",
		"saveList": false,
		"cleanOpened": false ,
		"autoClose": false     
	
		});
	}
	
	var settings = JSON.parse(window.localStorage.appSettings);
	return settings;
}
 
 function resetDefaultPrefs(){
	 //resets defaults
	window.localStorage.appSettings = JSON.stringify({ 
		"newTab": true, 
			"dedicatedWindow": false, 
		"newWindow": false, 
		"xPerWindow": false,
		"xNum": "10" ,
		"maxTotal": false,
		"xNumTotal": "25",
		"saveList": false,
		"cleanOpened": false,
		"autoClose": false   
		
		});
		var settings = JSON.parse(window.localStorage.appSettings);

	document.getElementById("newTab").checked = settings.newTab;
	
		if(settings.newTab==false){ document.getElementById('dedicatedWindowCheckbox').style.display="none"; }
	else{ document.getElementById('dedicatedWindowCheckbox').style.display="inline"; }
	
	
	document.getElementById("newWindow").checked = settings.newWindow;
	document.getElementById("dedicatedWindow").checked = settings.dedicatedWindow;
	document.getElementById("xPerWindow").checked = settings.xPerWindow;
	document.getElementById("xNum").value = settings.xNum;
	document.getElementById("maxTotal").checked = settings.maxTotal;
	document.getElementById("xNumTotal").value = settings.xNumTotal;
	
	document.getElementById("saveList").checked = settings.saveList;	
	document.getElementById("autoClose").checked = settings.autoClose;
	if( (settings.saveList==false && settings.autoClose==true) ){ document.getElementById('subOptionSave').style.display="none"; }
	else{ document.getElementById('subOptionSave').style.display="inline"; }
	document.getElementById("cleanOpened").checked = settings.cleanOpened;
	
	
	saveSettings(); 
}

function saveSettings() {
	
	var settings = JSON.parse(window.localStorage.appSettings);
	
	settings.newTab = document.getElementById("newTab").checked;
	
	if(settings.newTab==false){ document.getElementById('dedicatedWindowCheckbox').style.display="none"; }
	else{ document.getElementById('dedicatedWindowCheckbox').style.display="inline"; }
	
	settings.newWindow = document.getElementById("newWindow").checked;
	settings.dedicatedWindow = document.getElementById("dedicatedWindow").checked;
	settings.xPerWindow = document.getElementById("xPerWindow").checked;
	settings.xNum = document.getElementById("xNum").value;
	settings.maxTotal = document.getElementById("maxTotal").checked;
	settings.xNumTotal = document.getElementById("xNumTotal").value;
	settings.saveList = document.getElementById("saveList").checked;
	settings.autoClose = document.getElementById("autoClose").checked;
	if( (settings.saveList==false && settings.autoClose==true) ){ document.getElementById('subOptionSave').style.display="none"; }
	else{ document.getElementById('subOptionSave').style.display="inline"; }
	settings.cleanOpened = document.getElementById("cleanOpened").checked;
	

	
	window.localStorage.appSettings = JSON.stringify(settings);
	
}

function showError(string){
	document.getElementById('box2').style.display="none";
	document.getElementById('box1').style.display="block";
	document.getElementById('error').innerHTML=string;
	document.getElementById('error').style.display="inline";
	setTimeout(function(){ document.getElementById('error').style.display="none"; },5000);
}

var currTab=null, currWin=null;
var dedicatedWindow = null;

var lines = []; //used by all sub methods !
var totalOpened = 0;

	//save app's tab and window
	chrome.tabs.getCurrent(function(tab){
	  //  console.log(tab.id);
		currTab=tab;
	});
	chrome.windows.getCurrent(function(win){
	  //  console.log(win.id);
		currWin=win;
	});
	
function openURLs(){
	
	/* ************************ */
	/* Open URLs Button Clicked */
	/* ************************ */
	
	document.getElementById('box2').style.display="block";
	document.getElementById('box1').style.display="none"; 
	document.getElementById('counter').innerHTML="Opening Pages...";
	
	var settings = loadSettings(); //load current settings

	var uri = new URI("");
	var current='';
	
	//get textarea content
	var textarea= document.getElementById('urls').value;
	//if(textarea==''){showError("You must enter at least one URL in the box below ...");return;}
	var didWeOpenAnything=false;
	totalOpened=0;
	lines = textarea.split('\n');	
	var s1=0;
	for(var i = 0;i < lines.length;i++){ // MAIN URL LIST LOOP
    	//   lines[i]  will give you each line
		//console.log(lines[i]);
		s1=s1+1;
		if(settings.maxTotal)if(totalOpened>=settings.xNumTotal)break;
		
		uri =  URI(lines[i]);
		// normalize protocol and so on
		uri.normalize(); // returns the URI instance for chaining
		if( uri.href()!=''){ //if not an empty space...
			didWeOpenAnything=true; //we opened at least one URL
			totalOpened++;
			if(uri.scheme()==''){current='http://'+uri.href();}
			else{current=uri.href();}
			
			// check if we plan to close app on end to set "active" tab...
			var isActive = false;
			if( settings.autoClose==true ){isActive = true;} 
			
			// open it:
			
			if(settings.newTab==true){ //in new tabs...
				if(settings.dedicatedWindow==true){ //in dedicated window?
					if(dedicatedWindow==null){ //create dedicated window now
						chrome.windows.create({"url": current}, function(win){	
								dedicatedWindow=win;  
								theRestInDedicatedWin();
							} );
						return; // we break and return because the rest will be processed in separate function!
					} else{
						// dedicated window exists, procesed in separate function
					}
				} else {
					chrome.tabs.create({url: current, "active":isActive});
				}
				
			} else if(settings.newWindow==true){ //in new window each!
				chrome.windows.create({"url": current});
			}
			
			
		} //end if empty line...
			
			// var indexToRemove = 0;
			// var numberToRemove = 1;
			// arr.splice(indexToRemove, numberToRemove);
		if(settings.cleanOpened==true && settings.autoClose==false){ //remove processed line				
			lines.shift();
			//console.log(lines);	
			i--;	
			//document.getElementById('urls').value = lines.join("\n"); 		
		}		
			
	} // END of MAIN URL LIST LOOP
	
	if(settings.cleanOpened==true ){ //remove processed lines		
			if(settings.autoClose==true){ for(var ff=1; ff < s1;ff++){ lines.shift(); } }								
			document.getElementById('urls').value = lines.join("\n"); 				
		}	
	
			//if we don't plan to autoclose -- bring app window/tab to front
			if( settings.autoClose==false && settings.newTab==true){
				chrome.tabs.update(currTab.id, {"active":true});
				chrome.windows.update(currWin.id, {"focused":true});
			}
		//don't close if we have an error
		if(didWeOpenAnything==''){showError("You must enter at least one URL in the box below ...");document.getElementById('urls').value='';return;}	
		// close the app
		if( settings.autoClose==true ){
			 chrome.tabs.remove(currTab.id);
		}
	document.getElementById('box2').style.display="none";
	document.getElementById('box1').style.display="block";
}



function theRestInDedicatedWin(){
	
	var settings = loadSettings(); //load current settings

	var uri = new URI("");
	var current='';
	
	// shift 1st url (already processed)
		lines.shift();
	// if we keep window opened, fix textarea content
		if(settings.cleanOpened==true && settings.autoClose==false){ //remove processed lines										
			document.getElementById('urls').value = lines.join("\n"); 				
		}
		
	// now -- go open the rest of the items in the new window
	
	totalOpened = 1; //we already opened the 1st one
	var s=0;
	for(var i = 0;i < lines.length;i++){ // MAIN URL LIST LOOP
    	//   lines[i]  will give you each line
		//console.log(lines[i]);
		s=s+1;
		if(settings.maxTotal)if(totalOpened>=settings.xNumTotal)break;

		uri =  URI(lines[i]);
		// normalize protocol and so on
		uri.normalize(); // returns the URI instance for chaining
		if( uri.href()!=''){ //if not an empty space...
	
			totalOpened++;

			if(uri.scheme()==''){current='http://'+uri.href();}
			else{current=uri.href();}
			
			// check if we plan to close app on end to set "active" tab...
			var isActive = false;
			if( settings.autoClose==true ){isActive = true;} 
			
			// open it:	

			chrome.tabs.create({"url": current,"windowId":dedicatedWindow.id});			
			
		} //end if not empty line...
			
		if(settings.cleanOpened==true && settings.autoClose==false){ //remove processed line				
			lines.shift();
			i--;	
		}		
			
	} // END of MAIN URL LIST LOOP
	
	if(settings.cleanOpened==true ){ //remove processed lines	
			
				//remove processed?
				if(settings.autoClose==true){ for(var j=1; j<s;j++){ lines.shift(); } }
									
				document.getElementById('urls').value = lines.join("\n"); 	
					
			/*	if(settings.saveList!=true){
					window.localStorage.URLs = JSON.stringify({ 
						"URLs": ''     	
						});
				} else { //save urls 
					if (!window.localStorage.URLs) {
						window.localStorage.URLs = JSON.stringify({ 		
						"URLs": ''     	
						});
					}	
					var settings1 = JSON.parse(window.localStorage.URLs);					
					settings1.URLs = lines.join("\n"); 						
					window.localStorage.URLs = JSON.stringify(settings1);
				}
			*/
		}	
	
		/*	//if we don't plan to autoclose -- bring app window/tab to front
			if( settings.autoClose==false ){
				chrome.tabs.update(currTab.id, {"active":true});
				chrome.windows.update(currWin.id, {"focused":true});
			}*/
		// close the app
		if( settings.autoClose==true ){
			 chrome.tabs.remove(currTab.id);
		}
	// cleanup dedicated window pointer
	dedicatedWindow = null;
	
	document.getElementById('box2').style.display="none";
	document.getElementById('box1').style.display="block";
}

window.onbeforeunload = function(){
	var settings = loadSettings();
	if(settings.saveList!=true){
		window.localStorage.URLs = JSON.stringify({ 
			"URLs": ''     	
			});
	} else { //save urls 
		if (!window.localStorage.URLs) {
			window.localStorage.URLs = JSON.stringify({ 		
			"URLs": ''     	
			});
		}
		
		settings = JSON.parse(window.localStorage.URLs);
		
		settings.URLs = document.getElementById("urls").value;
			
		window.localStorage.URLs = JSON.stringify(settings);
	}
}

window.onload = function() {

	// load app settings	
	var settings = loadSettings();

	
		
	document.getElementById("newTab").checked = settings.newTab;
	
	if(settings.newTab==false){ document.getElementById('dedicatedWindowCheckbox').style.display="none"; }
	else{ document.getElementById('dedicatedWindowCheckbox').style.display="inline"; }
	
	document.getElementById("newWindow").checked = settings.newWindow;
	document.getElementById("dedicatedWindow").checked = settings.dedicatedWindow;
	document.getElementById("xPerWindow").checked = settings.xPerWindow;
	document.getElementById("xNum").value = settings.xNum;
	document.getElementById("maxTotal").checked = settings.maxTotal;
	document.getElementById("xNumTotal").value = settings.xNumTotal;
	document.getElementById("saveList").checked = settings.saveList;	
	document.getElementById("autoClose").checked = settings.autoClose;
	if( (settings.saveList==false && settings.autoClose==true) ){ document.getElementById('subOptionSave').style.display="none"; }
	else{ document.getElementById('subOptionSave').style.display="inline"; }
	document.getElementById("cleanOpened").checked = settings.cleanOpened;
	
	
document.getElementById("newTab").onchange = function() { saveSettings(); };	
document.getElementById("dedicatedWindow").onchange = function() { saveSettings(); };	
document.getElementById("newWindow").onchange = function() { saveSettings(); };
document.getElementById("xPerWindow").onchange = function() { saveSettings(); };	
document.getElementById("xNum").onchange = function() { saveSettings(); };	
document.getElementById("maxTotal").onchange = function() { saveSettings(); };	
document.getElementById("xNumTotal").onchange = function() { saveSettings(); };	
document.getElementById("saveList").onchange = function() { saveSettings(); };	
document.getElementById("cleanOpened").onchange = function() { saveSettings(); };
document.getElementById("autoClose").onchange = function() { saveSettings(); };	

	
	document.getElementById("restoreDefaults").onclick = function() { resetDefaultPrefs(); };
	
	document.getElementById("openBtn").onclick = function() { openURLs(); };
	
	document.getElementById("pasteBtn").onclick = function() { 
		document.getElementById('urls').value='';
   		document.getElementById('urls').focus();
		document.execCommand('paste')
	};
	document.getElementById("copyBtn").onclick = function() { 
   		document.getElementById('urls').focus();document.getElementById('urls').select();
		document.execCommand('copy')
	};
	document.getElementById("clearBtn").onclick = function() { 
   		document.getElementById('urls').value='';
	};
	
if(settings.saveList==true){
		var urllst = JSON.parse(window.localStorage.URLs);
		document.getElementById('urls').value = urllst.URLs;
	} 
	
}

