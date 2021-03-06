`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:40 12/05/2014 
// Design Name: 
// Module Name:    SubClockDyn100MHz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SubClockDyn100MHz(
    input clk,
    input [9:0] Freq,
    output OUTCLK
    );
	 reg [25:0] wait1, div;
	 reg CLK_;
	 
	 assign OUTCLK = CLK_; // output clock
	 
	 // clear out variables
	 initial begin
		wait1 = 0;
		CLK_ = 0;
		div = 0;
	 end
	 
	 
	 always @(posedge clk) begin
		// wait until clock hits half of the counted time.
		wait1 <= wait1+1; // count up 1
		
		case(Freq) // dividers >> 2
				1: div <= 100000000;
				2: div <= 50000000;
				3: div <= 33333333;
				4: div <= 25000000;
				5: div <= 20000000;
				6: div <= 16666667;
				7: div <= 14285714;
				8: div <= 12500000;
				9: div <= 11111111;
				10: div <= 10000000;
				11: div <= 9090909;
				12: div <= 8333333;
				13: div <= 7692308;
				14: div <= 7142857;
				15: div <= 6666667;
				16: div <= 6250000;
				17: div <= 5882353;
				18: div <= 5555556;
				19: div <= 5263158;
				20: div <= 5000000;
				21: div <= 4761905;
				22: div <= 4545455;
				23: div <= 4347826;
				24: div <= 4166667;
				25: div <= 4000000;
				26: div <= 3846154;
				27: div <= 3703704;
				28: div <= 3571429;
				29: div <= 3448276;
				30: div <= 3333333;
				31: div <= 3225806;
				32: div <= 3125000;
				33: div <= 3030303;
				34: div <= 2941176;
				35: div <= 2857143;
				36: div <= 2777778;
				37: div <= 2702703;
				38: div <= 2631579;
				39: div <= 2564103;
				40: div <= 2500000;
				41: div <= 2439024;
				42: div <= 2380952;
				43: div <= 2325581;
				44: div <= 2272727;
				45: div <= 2222222;
				46: div <= 2173913;
				47: div <= 2127660;
				48: div <= 2083333;
				49: div <= 2040816;
				50: div <= 2000000;
				51: div <= 1960784;
				52: div <= 1923077;
				53: div <= 1886792;
				54: div <= 1851852;
				55: div <= 1818182;
				56: div <= 1785714;
				57: div <= 1754386;
				58: div <= 1724138;
				59: div <= 1694915;
				60: div <= 1666667;
				61: div <= 1639344;
				62: div <= 1612903;
				63: div <= 1587302;
				64: div <= 1562500;
				65: div <= 1538462;
				66: div <= 1515152;
				67: div <= 1492537;
				68: div <= 1470588;
				69: div <= 1449275;
				70: div <= 1428571;
				71: div <= 1408451;
				72: div <= 1388889;
				73: div <= 1369863;
				74: div <= 1351351;
				75: div <= 1333333;
				76: div <= 1315789;
				77: div <= 1298701;
				78: div <= 1282051;
				79: div <= 1265823;
				80: div <= 1250000;
				81: div <= 1234568;
				82: div <= 1219512;
				83: div <= 1204819;
				84: div <= 1190476;
				85: div <= 1176471;
				86: div <= 1162791;
				87: div <= 1149425;
				88: div <= 1136364;
				89: div <= 1123596;
				90: div <= 1111111;
				91: div <= 1098901;
				92: div <= 1086957;
				93: div <= 1075269;
				94: div <= 1063830;
				95: div <= 1052632;
				96: div <= 1041667;
				97: div <= 1030928;
				98: div <= 1020408;
				99: div <= 1010101;
				100: div <= 1000000;
				101: div <= 990099;
				102: div <= 980392;
				103: div <= 970874;
				104: div <= 961538;
				105: div <= 952381;
				106: div <= 943396;
				107: div <= 934579;
				108: div <= 925926;
				109: div <= 917431;
				110: div <= 909091;
				111: div <= 900901;
				112: div <= 892857;
				113: div <= 884956;
				114: div <= 877193;
				115: div <= 869565;
				116: div <= 862069;
				117: div <= 854701;
				118: div <= 847458;
				119: div <= 840336;
				120: div <= 833333;
				121: div <= 826446;
				122: div <= 819672;
				123: div <= 813008;
				124: div <= 806452;
				125: div <= 800000;
				126: div <= 793651;
				127: div <= 787402;
				128: div <= 781250;
				129: div <= 775194;
				130: div <= 769231;
				131: div <= 763359;
				132: div <= 757576;
				133: div <= 751880;
				134: div <= 746269;
				135: div <= 740741;
				136: div <= 735294;
				137: div <= 729927;
				138: div <= 724638;
				139: div <= 719424;
				140: div <= 714286;
				141: div <= 709220;
				142: div <= 704225;
				143: div <= 699301;
				144: div <= 694444;
				145: div <= 689655;
				146: div <= 684932;
				147: div <= 680272;
				148: div <= 675676;
				149: div <= 671141;
				150: div <= 666667;
				151: div <= 662252;
				152: div <= 657895;
				153: div <= 653595;
				154: div <= 649351;
				155: div <= 645161;
				156: div <= 641026;
				157: div <= 636943;
				158: div <= 632911;
				159: div <= 628931;
				160: div <= 625000;
				161: div <= 621118;
				162: div <= 617284;
				163: div <= 613497;
				164: div <= 609756;
				165: div <= 606061;
				166: div <= 602410;
				167: div <= 598802;
				168: div <= 595238;
				169: div <= 591716;
				170: div <= 588235;
				171: div <= 584795;
				172: div <= 581395;
				173: div <= 578035;
				174: div <= 574713;
				175: div <= 571429;
				176: div <= 568182;
				177: div <= 564972;
				178: div <= 561798;
				179: div <= 558659;
				180: div <= 555556;
				181: div <= 552486;
				182: div <= 549451;
				183: div <= 546448;
				184: div <= 543478;
				185: div <= 540541;
				186: div <= 537634;
				187: div <= 534759;
				188: div <= 531915;
				189: div <= 529101;
				190: div <= 526316;
				191: div <= 523560;
				192: div <= 520833;
				193: div <= 518135;
				194: div <= 515464;
				195: div <= 512821;
				196: div <= 510204;
				197: div <= 507614;
				198: div <= 505051;
				199: div <= 502513;
				200: div <= 500000;
				201: div <= 497512;
				202: div <= 495050;
				203: div <= 492611;
				204: div <= 490196;
				205: div <= 487805;
				206: div <= 485437;
				207: div <= 483092;
				208: div <= 480769;
				209: div <= 478469;
				210: div <= 476190;
				211: div <= 473934;
				212: div <= 471698;
				213: div <= 469484;
				214: div <= 467290;
				215: div <= 465116;
				216: div <= 462963;
				217: div <= 460829;
				218: div <= 458716;
				219: div <= 456621;
				220: div <= 454545;
				221: div <= 452489;
				222: div <= 450450;
				223: div <= 448430;
				224: div <= 446429;
				225: div <= 444444;
				226: div <= 442478;
				227: div <= 440529;
				228: div <= 438596;
				229: div <= 436681;
				230: div <= 434783;
				231: div <= 432900;
				232: div <= 431034;
				233: div <= 429185;
				234: div <= 427350;
				235: div <= 425532;
				236: div <= 423729;
				237: div <= 421941;
				238: div <= 420168;
				239: div <= 418410;
				240: div <= 416667;
				241: div <= 414938;
				242: div <= 413223;
				243: div <= 411523;
				244: div <= 409836;
				245: div <= 408163;
				246: div <= 406504;
				247: div <= 404858;
				248: div <= 403226;
				249: div <= 401606;
				250: div <= 400000;
				251: div <= 398406;
				252: div <= 396825;
				253: div <= 395257;
				254: div <= 393701;
				255: div <= 392157;
				256: div <= 390625;
				257: div <= 389105;
				258: div <= 387597;
				259: div <= 386100;
				260: div <= 384615;
				261: div <= 383142;
				262: div <= 381679;
				263: div <= 380228;
				264: div <= 378788;
				265: div <= 377358;
				266: div <= 375940;
				267: div <= 374532;
				268: div <= 373134;
				269: div <= 371747;
				270: div <= 370370;
				271: div <= 369004;
				272: div <= 367647;
				273: div <= 366300;
				274: div <= 364964;
				275: div <= 363636;
				276: div <= 362319;
				277: div <= 361011;
				278: div <= 359712;
				279: div <= 358423;
				280: div <= 357143;
				281: div <= 355872;
				282: div <= 354610;
				283: div <= 353357;
				284: div <= 352113;
				285: div <= 350877;
				286: div <= 349650;
				287: div <= 348432;
				288: div <= 347222;
				289: div <= 346021;
				290: div <= 344828;
				291: div <= 343643;
				292: div <= 342466;
				293: div <= 341297;
				294: div <= 340136;
				295: div <= 338983;
				296: div <= 337838;
				297: div <= 336700;
				298: div <= 335570;
				299: div <= 334448;
				300: div <= 333333;
				301: div <= 332226;
				302: div <= 331126;
				303: div <= 330033;
				304: div <= 328947;
				305: div <= 327869;
				306: div <= 326797;
				307: div <= 325733;
				308: div <= 324675;
				309: div <= 323625;
				310: div <= 322581;
				311: div <= 321543;
				312: div <= 320513;
				313: div <= 319489;
				314: div <= 318471;
				315: div <= 317460;
				316: div <= 316456;
				317: div <= 315457;
				318: div <= 314465;
				319: div <= 313480;
				320: div <= 312500;
				321: div <= 311526;
				322: div <= 310559;
				323: div <= 309598;
				324: div <= 308642;
				325: div <= 307692;
				326: div <= 306748;
				327: div <= 305810;
				328: div <= 304878;
				329: div <= 303951;
				330: div <= 303030;
				331: div <= 302115;
				332: div <= 301205;
				333: div <= 300300;
				334: div <= 299401;
				335: div <= 298507;
				336: div <= 297619;
				337: div <= 296736;
				338: div <= 295858;
				339: div <= 294985;
				340: div <= 294118;
				341: div <= 293255;
				342: div <= 292398;
				343: div <= 291545;
				344: div <= 290698;
				345: div <= 289855;
				346: div <= 289017;
				347: div <= 288184;
				348: div <= 287356;
				349: div <= 286533;
				350: div <= 285714;
				351: div <= 284900;
				352: div <= 284091;
				353: div <= 283286;
				354: div <= 282486;
				355: div <= 281690;
				356: div <= 280899;
				357: div <= 280112;
				358: div <= 279330;
				359: div <= 278552;
				360: div <= 277778;
				361: div <= 277008;
				362: div <= 276243;
				363: div <= 275482;
				364: div <= 274725;
				365: div <= 273973;
				366: div <= 273224;
				367: div <= 272480;
				368: div <= 271739;
				369: div <= 271003;
				370: div <= 270270;
				371: div <= 269542;
				372: div <= 268817;
				373: div <= 268097;
				374: div <= 267380;
				375: div <= 266667;
				376: div <= 265957;
				377: div <= 265252;
				378: div <= 264550;
				379: div <= 263852;
				380: div <= 263158;
				381: div <= 262467;
				382: div <= 261780;
				383: div <= 261097;
				384: div <= 260417;
				385: div <= 259740;
				386: div <= 259067;
				387: div <= 258398;
				388: div <= 257732;
				389: div <= 257069;
				390: div <= 256410;
				391: div <= 255754;
				392: div <= 255102;
				393: div <= 254453;
				394: div <= 253807;
				395: div <= 253165;
				396: div <= 252525;
				397: div <= 251889;
				398: div <= 251256;
				399: div <= 250627;
				400: div <= 250000;
				401: div <= 249377;
				402: div <= 248756;
				403: div <= 248139;
				404: div <= 247525;
				405: div <= 246914;
				406: div <= 246305;
				407: div <= 245700;
				408: div <= 245098;
				409: div <= 244499;
				410: div <= 243902;
				411: div <= 243309;
				412: div <= 242718;
				413: div <= 242131;
				414: div <= 241546;
				415: div <= 240964;
				416: div <= 240385;
				417: div <= 239808;
				418: div <= 239234;
				419: div <= 238663;
				420: div <= 238095;
				421: div <= 237530;
				422: div <= 236967;
				423: div <= 236407;
				424: div <= 235849;
				425: div <= 235294;
				426: div <= 234742;
				427: div <= 234192;
				428: div <= 233645;
				429: div <= 233100;
				430: div <= 232558;
				431: div <= 232019;
				432: div <= 231481;
				433: div <= 230947;
				434: div <= 230415;
				435: div <= 229885;
				436: div <= 229358;
				437: div <= 228833;
				438: div <= 228311;
				439: div <= 227790;
				440: div <= 227273;
				441: div <= 226757;
				442: div <= 226244;
				443: div <= 225734;
				444: div <= 225225;
				445: div <= 224719;
				446: div <= 224215;
				447: div <= 223714;
				448: div <= 223214;
				449: div <= 222717;
				450: div <= 222222;
				451: div <= 221729;
				452: div <= 221239;
				453: div <= 220751;
				454: div <= 220264;
				455: div <= 219780;
				456: div <= 219298;
				457: div <= 218818;
				458: div <= 218341;
				459: div <= 217865;
				460: div <= 217391;
				461: div <= 216920;
				462: div <= 216450;
				463: div <= 215983;
				464: div <= 215517;
				465: div <= 215054;
				466: div <= 214592;
				467: div <= 214133;
				468: div <= 213675;
				469: div <= 213220;
				470: div <= 212766;
				471: div <= 212314;
				472: div <= 211864;
				473: div <= 211416;
				474: div <= 210970;
				475: div <= 210526;
				476: div <= 210084;
				477: div <= 209644;
				478: div <= 209205;
				479: div <= 208768;
				480: div <= 208333;
				481: div <= 207900;
				482: div <= 207469;
				483: div <= 207039;
				484: div <= 206612;
				485: div <= 206186;
				486: div <= 205761;
				487: div <= 205339;
				488: div <= 204918;
				489: div <= 204499;
				490: div <= 204082;
				491: div <= 203666;
				492: div <= 203252;
				493: div <= 202840;
				494: div <= 202429;
				495: div <= 202020;
				496: div <= 201613;
				497: div <= 201207;
				498: div <= 200803;
				499: div <= 200401;
				500: div <= 200000;
				501: div <= 199601;
				502: div <= 199203;
				503: div <= 198807;
				504: div <= 198413;
				505: div <= 198020;
				506: div <= 197628;
				507: div <= 197239;
				508: div <= 196850;
				509: div <= 196464;
				510: div <= 196078;
				511: div <= 195695;
				512: div <= 195313;
				513: div <= 194932;
				514: div <= 194553;
				515: div <= 194175;
				516: div <= 193798;
				517: div <= 193424;
				518: div <= 193050;
				519: div <= 192678;
				520: div <= 192308;
				521: div <= 191939;
				522: div <= 191571;
				523: div <= 191205;
				524: div <= 190840;
				525: div <= 190476;
				526: div <= 190114;
				527: div <= 189753;
				528: div <= 189394;
				529: div <= 189036;
				530: div <= 188679;
				531: div <= 188324;
				532: div <= 187970;
				533: div <= 187617;
				534: div <= 187266;
				535: div <= 186916;
				536: div <= 186567;
				537: div <= 186220;
				538: div <= 185874;
				539: div <= 185529;
				540: div <= 185185;
				541: div <= 184843;
				542: div <= 184502;
				543: div <= 184162;
				544: div <= 183824;
				545: div <= 183486;
				546: div <= 183150;
				547: div <= 182815;
				548: div <= 182482;
				549: div <= 182149;
				550: div <= 181818;
				551: div <= 181488;
				552: div <= 181159;
				553: div <= 180832;
				554: div <= 180505;
				555: div <= 180180;
				556: div <= 179856;
				557: div <= 179533;
				558: div <= 179211;
				559: div <= 178891;
				560: div <= 178571;
				561: div <= 178253;
				562: div <= 177936;
				563: div <= 177620;
				564: div <= 177305;
				565: div <= 176991;
				566: div <= 176678;
				567: div <= 176367;
				568: div <= 176056;
				569: div <= 175747;
				570: div <= 175439;
				571: div <= 175131;
				572: div <= 174825;
				573: div <= 174520;
				574: div <= 174216;
				575: div <= 173913;
				576: div <= 173611;
				577: div <= 173310;
				578: div <= 173010;
				579: div <= 172712;
				580: div <= 172414;
				581: div <= 172117;
				582: div <= 171821;
				583: div <= 171527;
				584: div <= 171233;
				585: div <= 170940;
				586: div <= 170648;
				587: div <= 170358;
				588: div <= 170068;
				589: div <= 169779;
				590: div <= 169492;
				591: div <= 169205;
				592: div <= 168919;
				593: div <= 168634;
				594: div <= 168350;
				595: div <= 168067;
				596: div <= 167785;
				597: div <= 167504;
				598: div <= 167224;
				599: div <= 166945;
				600: div <= 166667;
				601: div <= 166389;
				602: div <= 166113;
				603: div <= 165837;
				604: div <= 165563;
				605: div <= 165289;
				606: div <= 165017;
				607: div <= 164745;
				608: div <= 164474;
				609: div <= 164204;
				610: div <= 163934;
				611: div <= 163666;
				612: div <= 163399;
				613: div <= 163132;
				614: div <= 162866;
				615: div <= 162602;
				616: div <= 162338;
				617: div <= 162075;
				618: div <= 161812;
				619: div <= 161551;
				620: div <= 161290;
				621: div <= 161031;
				622: div <= 160772;
				623: div <= 160514;
				624: div <= 160256;
				625: div <= 160000;
				626: div <= 159744;
				627: div <= 159490;
				628: div <= 159236;
				629: div <= 158983;
				630: div <= 158730;
				631: div <= 158479;
				632: div <= 158228;
				633: div <= 157978;
				634: div <= 157729;
				635: div <= 157480;
				636: div <= 157233;
				637: div <= 156986;
				638: div <= 156740;
				639: div <= 156495;
				640: div <= 156250;
				641: div <= 156006;
				642: div <= 155763;
				643: div <= 155521;
				644: div <= 155280;
				645: div <= 155039;
				646: div <= 154799;
				647: div <= 154560;
				648: div <= 154321;
				649: div <= 154083;
				650: div <= 153846;
				651: div <= 153610;
				652: div <= 153374;
				653: div <= 153139;
				654: div <= 152905;
				655: div <= 152672;
				656: div <= 152439;
				657: div <= 152207;
				658: div <= 151976;
				659: div <= 151745;
				660: div <= 151515;
				661: div <= 151286;
				662: div <= 151057;
				663: div <= 150830;
				664: div <= 150602;
				665: div <= 150376;
				666: div <= 150150;
				667: div <= 149925;
				668: div <= 149701;
				669: div <= 149477;
				670: div <= 149254;
				671: div <= 149031;
				672: div <= 148810;
				673: div <= 148588;
				674: div <= 148368;
				675: div <= 148148;
				676: div <= 147929;
				677: div <= 147710;
				678: div <= 147493;
				679: div <= 147275;
				680: div <= 147059;
				681: div <= 146843;
				682: div <= 146628;
				683: div <= 146413;
				684: div <= 146199;
				685: div <= 145985;
				686: div <= 145773;
				687: div <= 145560;
				688: div <= 145349;
				689: div <= 145138;
				690: div <= 144928;
				691: div <= 144718;
				692: div <= 144509;
				693: div <= 144300;
				694: div <= 144092;
				695: div <= 143885;
				696: div <= 143678;
				697: div <= 143472;
				698: div <= 143266;
				699: div <= 143062;
				700: div <= 142857;
				701: div <= 142653;
				702: div <= 142450;
				703: div <= 142248;
				704: div <= 142045;
				705: div <= 141844;
				706: div <= 141643;
				707: div <= 141443;
				708: div <= 141243;
				709: div <= 141044;
				710: div <= 140845;
				711: div <= 140647;
				712: div <= 140449;
				713: div <= 140252;
				714: div <= 140056;
				715: div <= 139860;
				716: div <= 139665;
				717: div <= 139470;
				718: div <= 139276;
				719: div <= 139082;
				720: div <= 138889;
				721: div <= 138696;
				722: div <= 138504;
				723: div <= 138313;
				724: div <= 138122;
				725: div <= 137931;
				726: div <= 137741;
				727: div <= 137552;
				728: div <= 137363;
				729: div <= 137174;
				730: div <= 136986;
				731: div <= 136799;
				732: div <= 136612;
				733: div <= 136426;
				734: div <= 136240;
				735: div <= 136054;
				736: div <= 135870;
				737: div <= 135685;
				738: div <= 135501;
				739: div <= 135318;
				740: div <= 135135;
				741: div <= 134953;
				742: div <= 134771;
				743: div <= 134590;
				744: div <= 134409;
				745: div <= 134228;
				746: div <= 134048;
				747: div <= 133869;
				748: div <= 133690;
				749: div <= 133511;
				750: div <= 133333;
				751: div <= 133156;
				752: div <= 132979;
				753: div <= 132802;
				754: div <= 132626;
				755: div <= 132450;
				756: div <= 132275;
				757: div <= 132100;
				758: div <= 131926;
				759: div <= 131752;
				760: div <= 131579;
				761: div <= 131406;
				762: div <= 131234;
				763: div <= 131062;
				764: div <= 130890;
				765: div <= 130719;
				766: div <= 130548;
				767: div <= 130378;
				768: div <= 130208;
				769: div <= 130039;
				770: div <= 129870;
				771: div <= 129702;
				772: div <= 129534;
				773: div <= 129366;
				774: div <= 129199;
				775: div <= 129032;
				776: div <= 128866;
				777: div <= 128700;
				778: div <= 128535;
				779: div <= 128370;
				780: div <= 128205;
				781: div <= 128041;
				782: div <= 127877;
				783: div <= 127714;
				784: div <= 127551;
				785: div <= 127389;
				786: div <= 127226;
				787: div <= 127065;
				788: div <= 126904;
				789: div <= 126743;
				790: div <= 126582;
				791: div <= 126422;
				792: div <= 126263;
				793: div <= 126103;
				794: div <= 125945;
				795: div <= 125786;
				796: div <= 125628;
				797: div <= 125471;
				798: div <= 125313;
				799: div <= 125156;
				800: div <= 125000;
				801: div <= 124844;
				802: div <= 124688;
				803: div <= 124533;
				804: div <= 124378;
				805: div <= 124224;
				806: div <= 124069;
				807: div <= 123916;
				808: div <= 123762;
				809: div <= 123609;
				810: div <= 123457;
				811: div <= 123305;
				812: div <= 123153;
				813: div <= 123001;
				814: div <= 122850;
				815: div <= 122699;
				816: div <= 122549;
				817: div <= 122399;
				818: div <= 122249;
				819: div <= 122100;
				820: div <= 121951;
				821: div <= 121803;
				822: div <= 121655;
				823: div <= 121507;
				824: div <= 121359;
				825: div <= 121212;
				826: div <= 121065;
				827: div <= 120919;
				828: div <= 120773;
				829: div <= 120627;
				830: div <= 120482;
				831: div <= 120337;
				832: div <= 120192;
				833: div <= 120048;
				834: div <= 119904;
				835: div <= 119760;
				836: div <= 119617;
				837: div <= 119474;
				838: div <= 119332;
				839: div <= 119190;
				840: div <= 119048;
				841: div <= 118906;
				842: div <= 118765;
				843: div <= 118624;
				844: div <= 118483;
				845: div <= 118343;
				846: div <= 118203;
				847: div <= 118064;
				848: div <= 117925;
				849: div <= 117786;
				850: div <= 117647;
				851: div <= 117509;
				852: div <= 117371;
				853: div <= 117233;
				854: div <= 117096;
				855: div <= 116959;
				856: div <= 116822;
				857: div <= 116686;
				858: div <= 116550;
				859: div <= 116414;
				860: div <= 116279;
				861: div <= 116144;
				862: div <= 116009;
				863: div <= 115875;
				864: div <= 115741;
				865: div <= 115607;
				866: div <= 115473;
				867: div <= 115340;
				868: div <= 115207;
				869: div <= 115075;
				870: div <= 114943;
				871: div <= 114811;
				872: div <= 114679;
				873: div <= 114548;
				874: div <= 114416;
				875: div <= 114286;
				876: div <= 114155;
				877: div <= 114025;
				878: div <= 113895;
				879: div <= 113766;
				880: div <= 113636;
				881: div <= 113507;
				882: div <= 113379;
				883: div <= 113250;
				884: div <= 113122;
				885: div <= 112994;
				886: div <= 112867;
				887: div <= 112740;
				888: div <= 112613;
				889: div <= 112486;
				890: div <= 112360;
				891: div <= 112233;
				892: div <= 112108;
				893: div <= 111982;
				894: div <= 111857;
				895: div <= 111732;
				896: div <= 111607;
				897: div <= 111483;
				898: div <= 111359;
				899: div <= 111235;
				900: div <= 111111;
				901: div <= 110988;
				902: div <= 110865;
				903: div <= 110742;
				904: div <= 110619;
				905: div <= 110497;
				906: div <= 110375;
				907: div <= 110254;
				908: div <= 110132;
				909: div <= 110011;
				910: div <= 109890;
				911: div <= 109769;
				912: div <= 109649;
				913: div <= 109529;
				914: div <= 109409;
				915: div <= 109290;
				916: div <= 109170;
				917: div <= 109051;
				918: div <= 108932;
				919: div <= 108814;
				920: div <= 108696;
				921: div <= 108578;
				922: div <= 108460;
				923: div <= 108342;
				924: div <= 108225;
				925: div <= 108108;
				926: div <= 107991;
				927: div <= 107875;
				928: div <= 107759;
				929: div <= 107643;
				930: div <= 107527;
				931: div <= 107411;
				932: div <= 107296;
				933: div <= 107181;
				934: div <= 107066;
				935: div <= 106952;
				936: div <= 106838;
				937: div <= 106724;
				938: div <= 106610;
				939: div <= 106496;
				940: div <= 106383;
				941: div <= 106270;
				942: div <= 106157;
				943: div <= 106045;
				944: div <= 105932;
				945: div <= 105820;
				946: div <= 105708;
				947: div <= 105597;
				948: div <= 105485;
				949: div <= 105374;
				950: div <= 105263;
				951: div <= 105152;
				952: div <= 105042;
				953: div <= 104932;
				954: div <= 104822;
				955: div <= 104712;
				956: div <= 104603;
				957: div <= 104493;
				958: div <= 104384;
				959: div <= 104275;
				960: div <= 104167;
				961: div <= 104058;
				962: div <= 103950;
				963: div <= 103842;
				964: div <= 103734;
				965: div <= 103627;
				966: div <= 103520;
				967: div <= 103413;
				968: div <= 103306;
				969: div <= 103199;
				970: div <= 103093;
				971: div <= 102987;
				972: div <= 102881;
				973: div <= 102775;
				974: div <= 102669;
				975: div <= 102564;
				976: div <= 102459;
				977: div <= 102354;
				978: div <= 102249;
				979: div <= 102145;
				980: div <= 102041;
				981: div <= 101937;
				982: div <= 101833;
				983: div <= 101729;
				984: div <= 101626;
				985: div <= 101523;
				986: div <= 101420;
				987: div <= 101317;
				988: div <= 101215;
				989: div <= 101112;
				990: div <= 101010;
				991: div <= 100908;
				992: div <= 100806;
				993: div <= 100705;
				994: div <= 100604;
				995: div <= 100503;
				996: div <= 100402;
				997: div <= 100301;
				998: div <= 100200;
				999: div <= 100100;
				1000: div <= 100000;
				1001: div <= 99900;
				1002: div <= 99800;
				1003: div <= 99701;
				1004: div <= 99602;
				1005: div <= 99502;
				1006: div <= 99404;
				1007: div <= 99305;
				1008: div <= 99206;
				1009: div <= 99108;
				1010: div <= 99010;
				1011: div <= 98912;
				1012: div <= 98814;
				1013: div <= 98717;
				1014: div <= 98619;
				1015: div <= 98522;
				1016: div <= 98425;
				1017: div <= 98328;
				1018: div <= 98232;
				1019: div <= 98135;
				1020: div <= 98039;
				1021: div <= 97943;
				1022: div <= 97847;
				1023: div <= 97752;
				1024: div <= 97656;

				default: div <= 1;
			endcase
		
		if(wait1 >= div>>1) begin // Divider is divided by 2
			wait1 <= 0; // reset clock
			CLK_ <= ~CLK_;
		end
	 end

endmodule
