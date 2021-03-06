`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:09:02 03/03/2014 
// Design Name: 
// Module Name:    Freq2Div 
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
module Freq2Div(
		input CLK,
		input [25:0] Freq1,
		input [25:0] Freq2,
		input [25:0] Freq3,
		input [25:0] Freq4,
		output [25:0] Div1,
		output [25:0] Div2,
		output [25:0] Div3,
		output [25:0] Div4
    );
	 
	 reg [25:0] Div1_,Div2_,Div3_,Div4_;
	 
	 assign Div1 = Div1_;
	 assign Div2 = Div2_;
	 assign Div3 = Div3_;
	 assign Div4 = Div4_;
	 
	 // do clock divisions
	 always @(posedge CLK) begin
			Div1_ = f2div(Freq1);
			Div2_ = f2div(Freq2);
			Div3_ = f2div(Freq3);
			Div4_ = f2div(Freq4);
	 end
	 
	 function f2div;
		input [25:0] freq;
		begin
			case(freq)
				1: f2div = 25000000;
				2: f2div = 12500000;
				3: f2div = 8333333;
				4: f2div = 6250000;
				5: f2div = 5000000;
				6: f2div = 4166667;
				7: f2div = 3571429;
				8: f2div = 3125000;
				9: f2div = 2777778;
				10: f2div = 2500000;
				11: f2div = 2272727;
				12: f2div = 2083333;
				13: f2div = 1923077;
				14: f2div = 1785714;
				15: f2div = 1666667;
				16: f2div = 1562500;
				17: f2div = 1470588;
				18: f2div = 1388889;
				19: f2div = 1315789;
				20: f2div = 1250000;
				21: f2div = 1190476;
				22: f2div = 1136364;
				23: f2div = 1086957;
				24: f2div = 1041667;
				25: f2div = 1000000;
				26: f2div = 961538;
				27: f2div = 925926;
				28: f2div = 892857;
				29: f2div = 862069;
				30: f2div = 833333;
				31: f2div = 806452;
				32: f2div = 781250;
				33: f2div = 757576;
				34: f2div = 735294;
				35: f2div = 714286;
				36: f2div = 694444;
				37: f2div = 675676;
				38: f2div = 657895;
				39: f2div = 641026;
				40: f2div = 625000;
				41: f2div = 609756;
				42: f2div = 595238;
				43: f2div = 581395;
				44: f2div = 568182;
				45: f2div = 555556;
				46: f2div = 543478;
				47: f2div = 531915;
				48: f2div = 520833;
				49: f2div = 510204;
				50: f2div = 500000;
				51: f2div = 490196;
				52: f2div = 480769;
				53: f2div = 471698;
				54: f2div = 462963;
				55: f2div = 454545;
				56: f2div = 446429;
				57: f2div = 438596;
				58: f2div = 431034;
				59: f2div = 423729;
				60: f2div = 416667;
				61: f2div = 409836;
				62: f2div = 403226;
				63: f2div = 396825;
				64: f2div = 390625;
				65: f2div = 384615;
				66: f2div = 378788;
				67: f2div = 373134;
				68: f2div = 367647;
				69: f2div = 362319;
				70: f2div = 357143;
				71: f2div = 352113;
				72: f2div = 347222;
				73: f2div = 342466;
				74: f2div = 337838;
				75: f2div = 333333;
				76: f2div = 328947;
				77: f2div = 324675;
				78: f2div = 320513;
				79: f2div = 316456;
				80: f2div = 312500;
				81: f2div = 308642;
				82: f2div = 304878;
				83: f2div = 301205;
				84: f2div = 297619;
				85: f2div = 294118;
				86: f2div = 290698;
				87: f2div = 287356;
				88: f2div = 284091;
				89: f2div = 280899;
				90: f2div = 277778;
				91: f2div = 274725;
				92: f2div = 271739;
				93: f2div = 268817;
				94: f2div = 265957;
				95: f2div = 263158;
				96: f2div = 260417;
				97: f2div = 257732;
				98: f2div = 255102;
				99: f2div = 252525;
				100: f2div = 250000;
				101: f2div = 247525;
				102: f2div = 245098;
				103: f2div = 242718;
				104: f2div = 240385;
				105: f2div = 238095;
				106: f2div = 235849;
				107: f2div = 233645;
				108: f2div = 231481;
				109: f2div = 229358;
				110: f2div = 227273;
				111: f2div = 225225;
				112: f2div = 223214;
				113: f2div = 221239;
				114: f2div = 219298;
				115: f2div = 217391;
				116: f2div = 215517;
				117: f2div = 213675;
				118: f2div = 211864;
				119: f2div = 210084;
				120: f2div = 208333;
				121: f2div = 206612;
				122: f2div = 204918;
				123: f2div = 203252;
				124: f2div = 201613;
				125: f2div = 200000;
				126: f2div = 198413;
				127: f2div = 196850;
				128: f2div = 195313;
				129: f2div = 193798;
				130: f2div = 192308;
				131: f2div = 190840;
				132: f2div = 189394;
				133: f2div = 187970;
				134: f2div = 186567;
				135: f2div = 185185;
				136: f2div = 183824;
				137: f2div = 182482;
				138: f2div = 181159;
				139: f2div = 179856;
				140: f2div = 178571;
				141: f2div = 177305;
				142: f2div = 176056;
				143: f2div = 174825;
				144: f2div = 173611;
				145: f2div = 172414;
				146: f2div = 171233;
				147: f2div = 170068;
				148: f2div = 168919;
				149: f2div = 167785;
				150: f2div = 166667;
				151: f2div = 165563;
				152: f2div = 164474;
				153: f2div = 163399;
				154: f2div = 162338;
				155: f2div = 161290;
				156: f2div = 160256;
				157: f2div = 159236;
				158: f2div = 158228;
				159: f2div = 157233;
				160: f2div = 156250;
				161: f2div = 155280;
				162: f2div = 154321;
				163: f2div = 153374;
				164: f2div = 152439;
				165: f2div = 151515;
				166: f2div = 150602;
				167: f2div = 149701;
				168: f2div = 148810;
				169: f2div = 147929;
				170: f2div = 147059;
				171: f2div = 146199;
				172: f2div = 145349;
				173: f2div = 144509;
				174: f2div = 143678;
				175: f2div = 142857;
				176: f2div = 142045;
				177: f2div = 141243;
				178: f2div = 140449;
				179: f2div = 139665;
				180: f2div = 138889;
				181: f2div = 138122;
				182: f2div = 137363;
				183: f2div = 136612;
				184: f2div = 135870;
				185: f2div = 135135;
				186: f2div = 134409;
				187: f2div = 133690;
				188: f2div = 132979;
				189: f2div = 132275;
				190: f2div = 131579;
				191: f2div = 130890;
				192: f2div = 130208;
				193: f2div = 129534;
				194: f2div = 128866;
				195: f2div = 128205;
				196: f2div = 127551;
				197: f2div = 126904;
				198: f2div = 126263;
				199: f2div = 125628;
				200: f2div = 125000;
				201: f2div = 124378;
				202: f2div = 123762;
				203: f2div = 123153;
				204: f2div = 122549;
				205: f2div = 121951;
				206: f2div = 121359;
				207: f2div = 120773;
				208: f2div = 120192;
				209: f2div = 119617;
				210: f2div = 119048;
				211: f2div = 118483;
				212: f2div = 117925;
				213: f2div = 117371;
				214: f2div = 116822;
				215: f2div = 116279;
				216: f2div = 115741;
				217: f2div = 115207;
				218: f2div = 114679;
				219: f2div = 114155;
				220: f2div = 113636;
				221: f2div = 113122;
				222: f2div = 112613;
				223: f2div = 112108;
				224: f2div = 111607;
				225: f2div = 111111;
				226: f2div = 110619;
				227: f2div = 110132;
				228: f2div = 109649;
				229: f2div = 109170;
				230: f2div = 108696;
				231: f2div = 108225;
				232: f2div = 107759;
				233: f2div = 107296;
				234: f2div = 106838;
				235: f2div = 106383;
				236: f2div = 105932;
				237: f2div = 105485;
				238: f2div = 105042;
				239: f2div = 104603;
				240: f2div = 104167;
				241: f2div = 103734;
				242: f2div = 103306;
				243: f2div = 102881;
				244: f2div = 102459;
				245: f2div = 102041;
				246: f2div = 101626;
				247: f2div = 101215;
				248: f2div = 100806;
				249: f2div = 100402;
				250: f2div = 100000;
				251: f2div = 99602;
				252: f2div = 99206;
				253: f2div = 98814;
				254: f2div = 98425;
				255: f2div = 98039;
				256: f2div = 97656;
				257: f2div = 97276;
				258: f2div = 96899;
				259: f2div = 96525;
				260: f2div = 96154;
				261: f2div = 95785;
				262: f2div = 95420;
				263: f2div = 95057;
				264: f2div = 94697;
				265: f2div = 94340;
				266: f2div = 93985;
				267: f2div = 93633;
				268: f2div = 93284;
				269: f2div = 92937;
				270: f2div = 92593;
				271: f2div = 92251;
				272: f2div = 91912;
				273: f2div = 91575;
				274: f2div = 91241;
				275: f2div = 90909;
				276: f2div = 90580;
				277: f2div = 90253;
				278: f2div = 89928;
				279: f2div = 89606;
				280: f2div = 89286;
				281: f2div = 88968;
				282: f2div = 88652;
				283: f2div = 88339;
				284: f2div = 88028;
				285: f2div = 87719;
				286: f2div = 87413;
				287: f2div = 87108;
				288: f2div = 86806;
				289: f2div = 86505;
				290: f2div = 86207;
				291: f2div = 85911;
				292: f2div = 85616;
				293: f2div = 85324;
				294: f2div = 85034;
				295: f2div = 84746;
				296: f2div = 84459;
				297: f2div = 84175;
				298: f2div = 83893;
				299: f2div = 83612;
				300: f2div = 83333;
				301: f2div = 83056;
				302: f2div = 82781;
				303: f2div = 82508;
				304: f2div = 82237;
				305: f2div = 81967;
				306: f2div = 81699;
				307: f2div = 81433;
				308: f2div = 81169;
				309: f2div = 80906;
				310: f2div = 80645;
				311: f2div = 80386;
				312: f2div = 80128;
				313: f2div = 79872;
				314: f2div = 79618;
				315: f2div = 79365;
				316: f2div = 79114;
				317: f2div = 78864;
				318: f2div = 78616;
				319: f2div = 78370;
				320: f2div = 78125;
				512: f2div = 48828;
				1024: f2div = 24414;
				1200: f2div = 20833;
				2048: f2div = 12207;
				2400: f2div = 10417;
				4096: f2div = 6104;
				8192: f2div = 3052;
				9600: f2div = 2604;
				16384: f2div = 1526;
				19200: f2div = 1302;
				32768: f2div = 763;
				38400: f2div = 651;
				57600: f2div = 434;
				65536: f2div = 381;
				115200: f2div = 217;
				131072: f2div = 191;
				250000: f2div = 100;
				262144: f2div = 95;
				500000: f2div = 50;
				524288: f2div = 48;
				1048576: f2div = 24;
				2097152: f2div = 12;
				4194304: f2div = 6;
				8388608: f2div = 3;
				16777216: f2div = 1;
			endcase
		end
	endfunction

endmodule
