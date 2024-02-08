package uploader_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.utils.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var fileRefMulti:FileReferenceList;
        public var kbs:Number;
        public var param:Object;
        public var filesUploaded:Number;
        public var fileQueue:Object;
        public var fileRefSingle:FileReference;
        public var allBytesTotal:Number;
        public var activeQueue:Object;
        public var filesChecked:Number;
        public var filesSelected:Number;
        public var allKbsAvg:Number;
        public var cancelQueue:Object;
        public var filesReplaced:Number;
        public var fileRefListener:Object;
        public var fileTypes:Object;
        public var allBytesLoaded:Number;
        public var browseBtn:MovieClip;
        public var fileRef:Object;
        public var errors:Number;
        public var counter:Number;

        public function MainTimeline()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        public function setButtonText() : void
        {
            if (param.buttonText)
            {
                browseBtn.empty.buttonText.text = unescape(param.buttonText);
            }// end if
            return;
        }// end function

        public function rfu_uploadFiles(param1:String, param2:Boolean) : void
        {
            var _loc_3:String;
            var _loc_4:*;
            var _loc_5:*;
            var _loc_6:*;
            if (param.checkScript && !param2)
            {
                if (param1)
                {
                    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuCheckExist\", [\"" + param.checkScript + "\",{\"" + param1 + "\":\"" + fileQueue[param1].name + "\"},\"" + param.folder + "\", true])");
                }
                else
                {
                    _loc_3 = "{";
                    for (_loc_4 in fileQueue)
                    {
                        // label
                        if (_loc_3 != "{")
                        {
                            _loc_3 = _loc_3 + ",";
                        }// end if
                        _loc_3 = _loc_3 + ("\"" + _loc_4 + "\":\"" + fileQueue[_loc_4].name + "\"");
                    }// end of for ... in
                    _loc_3 = _loc_3 + "}";
                    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuCheckExist\", [\"" + param.checkScript + "\"," + _loc_3 + ",\"" + param.folder + "\", false])");
                }// end else if
            }
            else
            {
                root.addEventListener(Event.ENTER_FRAME, uploadCounter);
                if (param1)
                {
                    if (fileQueue[param1])
                    {
                        uploadFile(fileQueue[param1], param1, true);
                    }// end if
                }
                else if (param.simUploadLimit)
                {
                    for (_loc_5 in fileQueue)
                    {
                        // label
                        if (!activeQueue[_loc_5])
                        {
                            if (objSize(activeQueue) < parseInt(param.simUploadLimit))
                            {
                                uploadFile(fileQueue[_loc_5], _loc_5, false);
                                activeQueue[_loc_5] = true;
                                continue;
                            }// end if
                            break;
                        }// end if
                    }// end of for ... in
                }
                else
                {
                    for (_loc_6 in fileQueue)
                    {
                        // label
                        uploadFile(fileQueue[_loc_6], _loc_6, false);
                    }// end of for ... in
                }// end else if
            }// end else if
            return;
        }// end function

        public function fileSelectHandler(param1:Event) : void
        {
            var _loc_3:Boolean;
            var _loc_4:*;
            var _loc_5:*;
            var _loc_2:String;
            if (!param.multi)
            {
                fileQueue = new Object();
                _loc_2 = randomString(6);
                fileQueue[_loc_2] = fileRef;
                ExternalInterface.call("$(\"#" + param.fileUploadID + "Queue\").empty()");
                ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuSelect\",[\"" + _loc_2 + "\",{\"name\":\"" + fileQueue[_loc_2].name + "\",\"size\":" + fileQueue[_loc_2].size + ",\"creationDate\":\"" + fileQueue[_loc_2].creationDate + "\",\"modificationDate\":\"" + fileQueue[_loc_2].modificationDate + "\",\"type\":\"" + fileQueue[_loc_2].type + "\"}])");
                filesSelected = 1;
            }
            else
            {
                _loc_3 = false;
                _loc_4 = 0;
                while (_loc_4++ < fileRef.fileList.length)
                {
                    // label
                    for (_loc_5 in fileQueue)
                    {
                        // label
                        if (fileQueue[_loc_5].name == fileRef.fileList[_loc_4].name)
                        {
                            _loc_3 = true;
                            fileQueue[_loc_5] = fileRef.fileList[_loc_4];
                            filesReplaced++;
                        }// end if
                    }// end of for ... in
                    if (true)
                    {
                        _loc_2 = randomString(6);
                        fileQueue[_loc_2] = fileRef.fileList[_loc_4];
                        filesSelected++;
                        allBytesTotal = allBytesTotal + fileQueue[_loc_2].size;
                        ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuSelect\",[\"" + _loc_2 + "\",{\"name\":\"" + fileQueue[_loc_2].name + "\",\"size\":" + fileQueue[_loc_2].size + ",\"creationDate\":\"" + fileQueue[_loc_2].creationDate + "\",\"modificationDate\":\"" + fileQueue[_loc_2].modificationDate + "\",\"type\":\"" + fileQueue[_loc_2].type + "\"}])");
                    }// end if
                    _loc_3 = false;
                }// end while
            }// end else if
            ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuSelectOnce\",[{\"fileCount\":" + objSize(fileQueue) + ",\"filesSelected\":" + filesSelected + ",\"filesReplaced\":" + filesReplaced + ",\"allBytesTotal\":" + allBytesTotal + "}])");
            filesSelected = 0;
            filesReplaced = 0;
            if (param.auto)
            {
                if (param.checkScript)
                {
                    rfu_uploadFiles(null, false);
                }
                else
                {
                    rfu_uploadFiles(null, false);
                }// end if
            }// end else if
            return;
        }// end function

        public function objSize(param1:Object) : Number
        {
            var _loc_3:*;
            var _loc_2:Number;
            for (_loc_3 in param1)
            {
                // label
            }// end of for ... in
            return _loc_2++;
        }// end function

        public function setFileTypes() : void
        {
            if (param.fileDesc && param.fileExt)
            {
                fileTypes = new FileFilter(param.fileDesc, param.fileExt);
            }// end if
            return;
        }// end function

        public function uploadFile(param1:FileReference, param2:String, param3:Boolean) : void
        {
            var startTimer:Number;
            var lastBytesLoaded:Number;
            var kbsAvg:Number;
            var fileOpenHandler:Function;
            var fileProgressHandler:Function;
            var fileCompleteHandler:Function;
            var scriptURL:URLRequest;
            var file:* = param1;
            var queueID:* = param2;
            var single:* = param3;
            fileOpenHandler = 
function (param1:Event)
{
    startTimer = getTimer();
    return;
}// end function
;
            fileProgressHandler = 
function (param1:ProgressEvent) : void
{
    var _loc_2:* = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
    if (getTimer() - startTimer >= 150)
    {
        kbs = (param1.bytesLoaded - lastBytesLoaded) / 1024 / ((getTimer() - startTimer) / 1000);
        kbs = int(kbs * 10) / 10;
        startTimer = getTimer();
        if (kbsAvg > 0)
        {
            kbsAvg = (kbsAvg + kbs) / 2;
        }
        else
        {
            kbsAvg = kbs;
        }// end else if
        allKbsAvg = (allKbsAvg + kbsAvg) / 2;
    }// end if
    allBytesLoaded = allBytesLoaded + (param1.bytesLoaded - lastBytesLoaded);
    lastBytesLoaded = param1.bytesLoaded;
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuProgress\",[\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},{\"percentage\":" + _loc_2 + ",\"bytesLoaded\":" + param1.bytesLoaded + ",\"allBytesLoaded\":" + allBytesLoaded + ",\"speed\":" + kbs + "}])");
    return;
}// end function
;
            fileCompleteHandler = 
function (param1:DataEvent) : void
{
    if (kbsAvg == 0)
    {
        kbs = file.size / 1024 / ((getTimer() - startTimer) / 1000);
        kbsAvg = kbs;
        allKbsAvg = (allKbsAvg + kbsAvg) / 2;
    }// end if
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuProgress\",[\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},{\"percentage\":100,\"bytesLoaded\":" + param1.currentTarget.size + ",\"allBytesLoaded\":" + allBytesLoaded + ",\"speed\":" + kbs + "}])");
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuComplete\", [\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"filePath\":\"" + getFolderPath() + "/" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},\"" + escape(param1.data) + "\",{\"fileCount\":" + objSize(fileQueue)-- + ",\"speed\":" + kbsAvg + "}])");
    filesUploaded++;
    delete fileQueue[queueID];
    if (param.simUploadLimit && !single)
    {
        delete activeQueue[queueID];
        rfu_uploadFiles(null, true);
    }// end if
    if (objSize(fileQueue) == 0)
    {
        ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuAllComplete\",[{\"filesUploaded\":" + filesUploaded + ",\"errors\":" + errors + ",\"allBytesLoaded\":" + allBytesLoaded + ",\"speed\":" + allKbsAvg + "}])");
        root.removeEventListener(Event.ENTER_FRAME, uploadCounter);
        filesUploaded = 0;
        errors = 0;
        allBytesLoaded = 0;
        allBytesTotal = 0;
        allKbsAvg = 0;
        filesChecked = 0;
        param1.currentTarget.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, fileCompleteHandler);
    }// end if
    return;
}// end function
;
            startTimer;
            lastBytesLoaded;
            kbsAvg;
            file.addEventListener(Event.OPEN, fileOpenHandler);
            file.addEventListener(ProgressEvent.PROGRESS, fileProgressHandler);
            file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, fileCompleteHandler);
            file.addEventListener(HTTPStatusEvent.HTTP_STATUS, 
function (param1:HTTPStatusEvent) : void
{
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuError\",[\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},{\"type\":\"HTTP\",\"status\":\"" + param1.status + "\"}])");
    errors++;
    delete fileQueue[queueID];
    return;
}// end function
);
            file.addEventListener(IOErrorEvent.IO_ERROR, 
function (param1:IOErrorEvent) : void
{
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuError\",[\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},{\"type\":\"IO\",\"text\":\"" + param1.text + "\"}])");
    errors++;
    delete fileQueue[queueID];
    return;
}// end function
);
            file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
function (param1:SecurityErrorEvent) : void
{
    ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuError\",[\"" + queueID + "\",{\"name\":\"" + param1.currentTarget.name + "\",\"size\":" + param1.currentTarget.size + ",\"creationDate\":\"" + param1.currentTarget.creationDate + "\",\"modificationDate\":\"" + param1.currentTarget.modificationDate + "\",\"type\":\"" + param1.currentTarget.type + "\"},{\"type\":\"Security\",\"text\":\"" + param1.text + "\"}])");
    errors++;
    delete fileQueue[queueID];
    return;
}// end function
);
            if (param.sizeLimit && file.size > parseInt(param.sizeLimit))
            {
                ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuError\",[\"" + queueID + "\",{\"name\":\"" + file.name + "\",\"size\":" + file.size + ",\"creationDate\":\"" + file.creationDate + "\",\"modificationDate\":\"" + file.modificationDate + "\",\"type\":\"" + file.type + "\"},{\"type\":\"File Size\",\"sizeLimit\":" + param.sizeLimit + "}])");
                errors++;
                delete fileQueue[queueID];
            }
            else
            {
                if (param.script.substr(0, 1) != "/")
                {
                    param.script = param.pagepath + param.script;
                }// end if
                scriptURL = new URLRequest(param.script + "?folder=" + unescape(getFolderPath()) + unescape(param.scriptData));
                file.upload(scriptURL, param.fileDataName);
            }// end else if
            return;
        }// end function

        public function rfu_cancelFileUpload(param1:String) : void
        {
            if (fileQueue[param1])
            {
                fileQueue[param1].cancel();
                allBytesTotal = allBytesTotal - fileQueue[param1].size;
                ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuCancel\", [\"" + param1 + "\",{\"name\":\"" + fileQueue[param1].name + "\",\"size\":" + fileQueue[param1].size + ",\"creationDate\":\"" + fileQueue[param1].creationDate + "\",\"modificationDate\":\"" + fileQueue[param1].modificationDate + "\",\"type\":\"" + fileQueue[param1].type + "\"},{\"fileCount\":" + objSize(fileQueue)-- + ",\"allBytesTotal\":" + allBytesTotal + "}])");
                delete fileQueue[param1];
                if (param.simUploadLimit && activeQueue[param1])
                {
                    delete activeQueue[param1];
                    rfu_uploadFiles(null, true);
                }// end if
                root.removeEventListener(Event.ENTER_FRAME, uploadCounter);
            }// end if
            return;
        }// end function

        public function rfu_clearFileUploadQueue() : void
        {
            var _loc_1:*;
            for (_loc_1 in fileQueue)
            {
                // label
                rfu_cancelFileUpload(_loc_1);
            }// end of for ... in
            ExternalInterface.call("$(\"#" + param.fileUploadID + "\").trigger(\"rfuClearQueue\",[{\"fileCount\":" + objSize(fileQueue) + ",\"allBytesTotal\":" + allBytesTotal + "}])");
            return;
        }// end function

        public function getFolderPath() : String
        {
            var _loc_2:Array;
            var _loc_3:*;
            var _loc_1:* = param.folder;
            if (param.folder.substr(0, 1) != "/")
            {
                _loc_1 = param.pagepath + param.folder;
                _loc_2 = _loc_1.split("/");
                _loc_3 = 0;
                while (_loc_3++ < _loc_2.length)
                {
                    // label
                    if (_loc_2[_loc_3] == "..")
                    {
                        _loc_2.splice(_loc_3--, 2);
                    }// end if
                }// end while
                _loc_1 = _loc_2.join("/");
            }// end if
            return _loc_1;
        }// end function

        public function uploadCounter(param1:Event) : void
        {
            counter++;
            return;
        }// end function

        public function randomString(param1:Number) : String
        {
            var _loc_4:Number;
            var _loc_2:Array;
            var _loc_3:String;
            var _loc_5:*;
            while (_loc_5++ < param1)
            {
                // label
                _loc_4 = Math.floor(Math.random() * 25);
                _loc_3 = _loc_3 + _loc_2[_loc_4];
            }// end while
            return _loc_3;
        }// end function

        public function rfu_updateSettings(param1:String, param2) : void
        {
            param[param1] = param2;
            if (param1 == "buttonImg")
            {
                setButtonImg();
            }// end if
            if (param1 == "buttonText")
            {
                setButtonText();
            }// end if
            if (param1 == "fileDesc" || param1 == "fileExt")
            {
                setFileTypes();
            }// end if
            if (param1 == "multi")
            {
                setMulti();
            }// end if
            if (param1 == "width" || param1 == "height")
            {
                setButtonSize();
            }// end if
            return;
        }// end function

        public function setButtonSize() : void
        {
            if (param.hideButton)
            {
                browseBtn.width = param.btnWidth;
                browseBtn.height = param.btnHeight;
            }// end if
            ExternalInterface.call("$(\"#" + param.fileUploadID + "\").attr(\"width\"," + param.btnWidth + ")");
            ExternalInterface.call("$(\"#" + param.fileUploadID + "\").attr(\"height\"," + param.btnHeight + ")");
            return;
        }// end function

        function frame1()
        {
            param = LoaderInfo(this.root.loaderInfo).parameters;
            fileRefSingle = new FileReference();
            fileRefMulti = new FileReferenceList();
            fileRefListener = new Object();
            fileQueue = new Object();
            activeQueue = new Object();
            cancelQueue = new Object();
            counter = 0;
            filesSelected = 0;
            filesReplaced = 0;
            filesUploaded = 0;
            filesChecked = 0;
            errors = 0;
            kbs = 0;
            allBytesLoaded = 0;
            allBytesTotal = 0;
            allKbsAvg = 0;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            setButtonImg();
            setButtonText();
            browseBtn.buttonMode = true;
            browseBtn.useHandCursor = true;
            browseBtn.mouseChildren = false;
            setButtonSize();
            if (param.rollover)
            {
                browseBtn.addEventListener(MouseEvent.ROLL_OVER, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = -param.btnHeight;
    return;
}// end function
);
                browseBtn.addEventListener(MouseEvent.ROLL_OUT, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = 0;
    return;
}// end function
);
                browseBtn.addEventListener(MouseEvent.MOUSE_DOWN, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = -param.btnHeight * 2;
    return;
}// end function
);
            }// end if
            if (!param.scriptData)
            {
                param.scriptData = "";
            }// end if
            setMulti();
            setFileTypes();
            browseBtn.addEventListener(MouseEvent.CLICK, 
function () : void
{
    if (!fileTypes)
    {
        fileRef.browse();
    }
    else
    {
        fileRef.browse([fileTypes]);
    }// end else if
    return;
}// end function
);
            fileRef.addEventListener(Event.SELECT, fileSelectHandler);
            ExternalInterface.addCallback("updateSettings", rfu_updateSettings);
            ExternalInterface.addCallback("startFileUpload", rfu_uploadFiles);
            ExternalInterface.addCallback("cancelFileUpload", rfu_cancelFileUpload);
            ExternalInterface.addCallback("clearFileUploadQueue", rfu_clearFileUploadQueue);
            return;
        }// end function

        public function setButtonImg() : void
        {
            var _loc_1:Loader;
            var _loc_2:URLRequest;
            if (param.buttonImg)
            {
                _loc_1 = new Loader();
                browseBtn.addChild(_loc_1);
                _loc_2 = new URLRequest(param.buttonImg);
                _loc_1.load(_loc_2);
            }// end if
            if (!param.hideButton && !param.buttonImg)
            {
                browseBtn.empty.alpha = 1;
            }// end if
            return;
        }// end function

        public function setMulti() : void
        {
            if (!param.multi)
            {
                fileRef = fileRefSingle;
            }
            else
            {
                fileRef = fileRefMulti;
            }// end else if
            return;
        }// end function

    }
}
