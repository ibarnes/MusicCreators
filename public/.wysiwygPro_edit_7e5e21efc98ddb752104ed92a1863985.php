<?php ob_start() ?>
<?php
if ($_GET['randomId'] != "HqxFO4874ZWDUNCmsD45beBs7nHvJcGKwruTjaeuzIENKGM1SKKrAJs4MOwJ1gDSciTsfN7F4F7YLbsH9EMAXPloBSvYKNMrFzlH0nYdPxE2Kz2kEvHxVMKOAcDepb7ComNDwOkMPtbo5a1cr12qe8f6Yo6VqfzUmlX4F31qLJzfZPS_9qiJqcWojOJeaS16jwXDXMSGQ4QROvOMXEEh0OLASRWyB4oRHLM2VHn9iRnhUbf3tlCB3ppwQjzi6X1O") {
    echo "Access Denied";
    exit();
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Editing 500.html</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">body {background-color:threedface; border: 0px 0px; padding: 0px 0px; margin: 0px 0px}</style>
</head>
<body>
<div align="center">

<div id="saveform" style="display:none;">
<form METHOD="POST" name=mform action="https://vps.beatcreators.com:2083/frontend/x3/filemanager/savehtmlfile.html">
    <input type="hidden" name="charset" value="utf-8">
    <input type="hidden" name="baseurl" value="http://beatcreators.com/">
    <input type="hidden" name="basedir" value="/home/beatc2/beta/public/">
    <input type="hidden" name="udir" value="/home/beatc2/beta/public">
    <input type="hidden" name="ufile" value="500.html">
    <input type="hidden" name="dir" value="%2fhome%2fbeatc2%2fbeta%2fpublic">
    <input type="hidden" name="file" value="500.html">
    <input type="hidden" name="doubledecode" value="1">
<textarea name=page rows=1 cols=1></textarea></form>
</div>
<div id="abortform" style="display:none;">
<form METHOD="POST" name="abortform" action="https://vps.beatcreators.com:2083/frontend/x3/filemanager/aborthtmlfile.html">
    <input type="hidden" name="charset" value="utf-8">
    <input type="hidden" name="baseurl" value="http://beatcreators.com/">
    <input type="hidden" name="basedir" value="/home/beatc2/beta/public/">
    <input type="hidden" name="dir" value="%2fhome%2fbeatc2%2fbeta%2fpublic">
        <input type="hidden" name="file" value="500.html">
    <input type="hidden" name="udir" value="/home/beatc2/beta/public">
    <input type="hidden" name="ufile" value="500.html">

        </form>
</div>
<script language="javascript">
<!--//

function setHtmlFilters(editor) {
// Design view filter
editor.addHTMLFilter('design', function (editor, html) {
        return html.replace(/\<meta\s+http\-equiv\="Content\-Type"[^\>]+\>/gi, '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
});

// Source view filter
editor.addHTMLFilter('source', function (editor, html) {
        return html.replace(/\<meta\s+http\-equiv\="Content\-Type"[^\>]+\>/gi, '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
});
}

// this function updates the code in the textarea and then closes this window
function do_save() {
    document.mform.page.value = WPro.editors[0].getValue();
	document.mform.submit();
}
function do_abort() {
	document.abortform.submit();
}
//-->
</script>
<?php
// make sure these includes point correctly:
include_once ('/usr/local/cpanel/base/3rdparty/wysiwygPro/wysiwygPro.class.php');

// create a new instance of the wysiwygPro class:
$editor = new wysiwygPro();

$editor->registerButton('save', 'Save',
        'do_save();', '##buttonURL##save.gif', 22, 22,
        'savehandler'); 
$editor->addRegisteredButton('save', 'before:print' );
$editor->addJSButtonStateHandler ('savehandler', 'function (EDITOR,srcElement,cid,inTable,inA,range){ 
        return "wproReady"; 
        }'); 


$editor->registerButton('cancel', 'Cancel',
        'do_abort();', '##buttonURL##close.gif', 22, 22,
        'cancelhandler'); 
$editor->addRegisteredButton('cancel', 'before:print' );
$editor->addJSButtonStateHandler ('cancelhandler', 'function (EDITOR,srcElement,cid,inTable,inA,range){ 
        return "wproReady"; 
        }'); 
$editor->theme = 'blue'; 
$editor->addJSEditorEvent('load', 'function(editor){editor.fullWindow();setHtmlFilters(editor);}');

$editor->baseURL = "http://beatcreators.com/";

$editor->loadValueFromFile('/home/beatc2/beta/public/500.html');

$editor->registerSeparator('savecan');

// add a spacer:
$editor->addRegisteredButton('savecan', 'after:cancel');

//$editor->set_charset('iso-8859-1');
$editor->mediaDir = '/home/beatc2/beta/public/';
$editor->mediaURL = 'http://beatcreators.com/';
$editor->imageDir = '/home/beatc2/beta/public/';
$editor->imageURL = 'http://beatcreators.com/';
$editor->documentDir = '/home/beatc2/beta/public/';
$editor->documentURL = 'http://beatcreators.com/';
$editor->emoticonDir = '/home/beatc2/beta/public/.smileys/';
$editor->emoticonURL = 'http://beatcreators.com/.smileys/';
$editor->loadPlugin('serverPreview'); 
$editor->plugins['serverPreview']->URL = 'http://beatcreators.com/.wysiwygPro_preview_7e5e21efc98ddb752104ed92a1863985.php?randomId=HqxFO4874ZWDUNCmsD45beBs7nHvJcGKwruTjaeuzIENKGM1SKKrAJs4MOwJ1gDSciTsfN7F4F7YLbsH9EMAXPloBSvYKNMrFzlH0nYdPxE2Kz2kEvHxVMKOAcDepb7ComNDwOkMPtbo5a1cr12qe8f6Yo6VqfzUmlX4F31qLJzfZPS_9qiJqcWojOJeaS16jwXDXMSGQ4QROvOMXEEh0OLASRWyB4oRHLM2VHn9iRnhUbf3tlCB3ppwQjzi6X1O';
// print the editor to the browser:
$editor->htmlCharset = 'utf-8';
$editor->urlFormat = 'relative';
$editor->display('100%','450');

?>
</div>
<script>

</script>

</body>
</html>
<?php ob_end_flush() ?>
