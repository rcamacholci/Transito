
// -- Deluxe Tuner Style Names
var tstylesNames=["Individual Style","Individual Style","Individual Style","Individual Style",];
var tXPStylesNames=["Individual Style",];
// -- End of Deluxe Tuner Style Names

//--- Common
var tlevelDX=20;
var texpanded=0;
var texpandItemClick=0;
var tcloseExpanded=1;
var tcloseExpandedXP=0;
var ttoggleMode=1;
var tnoWrap=1;
var titemTarget="init";
var titemCursor="pointer";
var statusString="link";
var tblankImage="../html/scripts/dataMenu.files/blank.gif";
var tpathPrefix_img="";
var tpathPrefix_link="";

//--- Dimensions
var tmenuWidth="230px";
var tmenuHeight="";

//--- Positioning
var tabsolute=0;
var tleft="20px";
var ttop="40px";

//--- Font
var tfontStyle="bold 8pt Arial";
var tfontColor=["#333333","#C0C0C0"];
var tfontDecoration=["none","none"];
var tfontColorDisabled="#ACACAC";
var tpressedFontColor="#0066CC";

//--- Appearance
var tmenuBackColor="#D2D2D2";
var tmenuBackImage="";
var tmenuBorderColor="#FFFFFF";
var tmenuBorderWidth=0;
var tmenuBorderStyle="solid";

//--- Item Appearance
var titemAlign="left";
var titemHeight=22;
var titemBackColor=["#F0F1F5","#F0F1F5"];
var titemBackImage=["",""];

//--- Icons & Buttons
var ticonWidth=21;
var ticonHeight=15;
var ticonAlign="left";
var texpandBtn=["../html/scripts/dataMenu.files/expandbtn2.gif","../html/scripts/dataMenu.files/icon3_s.gif","../html/scripts/dataMenu.files/collapsebtn2.gif"];
var texpandBtnW=9;
var texpandBtnH=9;
var texpandBtnAlign="left";

//--- Lines
var tpoints=0;
var tpointsImage="";
var tpointsVImage="";
var tpointsCImage="";
var tpointsBImage="";

//--- Floatable Menu
var tfloatable=0;
var tfloatIterations=10;
var tfloatableX=1;
var tfloatableY=1;

//--- Movable Menu
var tmoveable=0;
var tmoveHeight=12;
var tmoveColor="transparent";
var tmoveImage="../html/scripts/dataMenu.files/movepic.gif";

//--- XP-Style
var tXPStyle=1;
var tXPIterations=10;
var tXPBorderWidth=1;
var tXPBorderColor="#FFFFFF";
var tXPAlign="left";
var tXPTitleBackColor="#D8D8D8";
var tXPTitleBackImg="../html/scripts/dataMenu.files/xptitle2_s.gif";
var tXPTitleLeft="../html/scripts/dataMenu.files/xptitleleft_s.gif";
var tXPTitleLeftWidth=4;
var tXPIconWidth=30;
var tXPIconHeight=32;
var tXPMenuSpace=10;
var tXPExpandBtn=["../html/scripts/dataMenu.files/xpexpand2_s.gif","../html/scripts/dataMenu.files/xpexpand3_s.gif","../html/scripts/dataMenu.files/xpcollapse2_s.gif","../html/scripts/dataMenu.files/xpcollapse3_s.gif"];
var tXPBtnWidth=25;
var tXPBtnHeight=23;
var tXPFilter=1;

//--- Advanced
var tdynamic=0;
var tajax=0;

//--- State Saving
var tsaveState=0;
var tsavePrefix="menu1";

var tstyles = [
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6","tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C","tfontDecoration=none,none"],
    ["tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
];
var tXPStyles = [
    ["tXPTitleBackColor=#D9DAE2","tXPTitleBackImg=../html/scripts/dataMenu.files/xptitle2_s.gif","tXPExpandBtn=../html/scripts/dataMenu.files/xpexpand2_s.gif,../html/scripts/dataMenu.files/xpexpand3_s.gif,../html/scripts/dataMenu.files/xpcollapse2_s.gif,../html/scripts/dataMenu.files/xpcollapse3_s.gif"],
];

var tmenuItems = [
["Menu Civitrans","", "", "", "", "", "", "1", "0", "", ],
	["|Inicio","", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cambiar Password","editarPassword.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Preasignacion","", "", "", "", "", "", "1", "0", "", ],
        ["|Preasignacion Placa","preasignacion.jsp?tipoP=0", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
        ["|Consulta Preasignacion","consultarPreasignaciones.jsp?tipoP=0", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
];

dtree_init();