Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 PH7PR11MB8600.namprd11.prod.outlook.com with HTTPS; Mon, 18 Nov 2024 20:09:03
 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mXXwSYNErW4P+RnadlBW042G5/6L/aXWQ3ysBGSRJuScyZs2Le7USIbe0VvUeN8xotR/yXIGvL729YMVHizQ5ZUdthNFfhJRVqP1Pr4zbEZ70+xbloiaRaBTNdAktBnM3p6mdc4e9PJILpgotxaBAe/bhFaWBt5XWXHAXj5oJNJ/in4ckQZsn3Xh2fIfXpkErDcYMnbm0aqATKWvrG48ATsji+pPwfL6aBT+biR5GCp0F1CW5ImLQmsyfA6HxxV48qrR3dtTdZIrQ7DButSQ3aYydf/ODiiwrR/3pHwycOajlmksxKjInIxFibSc4AvAnGRMdUek5d3ppr0ktAf4kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgMJVUhhH9FF7hypY9l25M4JfyPl/5d4r+pqNT/h+lA=;
 b=m8PZJH/0+0BOcoQwxey1iXfS5lFSYyV9ufKD5trdwKLALbu9rboh5coenbreG18DzIql92o1/7x64zL8BTg21BGZwt78SpatZopMmfGxcU9FS/eDs+7CheR7wvWaA4Jzin51XGU+N8x2ZLPqMNmXJyfaHg/3FUa0jM3OYldCelMjseWLMmcTy+CDBR4RCnGtG9gM3SZ2NiKIjY4cu0z88Mw5xe9dvWW4DBfzDDqRRCuekJHxTesBIPCwardWOQOybgeqCUjCAHANmEAVz1rsZdFe/CnyFHf6kzWNYNBAcstWpucz09ebcxYCbERGpAkzTKdruZFBRtatVJDjdMliJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.189.246) smtp.rcpttodomain=ebnet.org smtp.mailfrom=mts-iss.com;
 dmarc=bestguesspass action=none header.from=mts-iss.com; dkim=pass (signature
 was verified) header.d=mts-iss.com; dkim=pass (signature was verified)
 header.d=netorg5099798.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=mts-iss.com] dkim=[1,1,header.d=mts-iss.com]
 dmarc=[1,1,header.from=mts-iss.com])
Received: from BL1PR13CA0103.namprd13.prod.outlook.com (2603:10b6:208:2b9::18)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 20:08:58 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::aa) by BL1PR13CA0103.outlook.office365.com
 (2603:10b6:208:2b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13 via Frontend
 Transport; Mon, 18 Nov 2024 20:08:57 +0000
Authentication-Results: spf=pass (sender IP is 205.220.189.246)
 smtp.mailfrom=mts-iss.com; dkim=pass (signature was verified)
 header.d=mts-iss.com;dkim=pass (signature was verified)
 header.d=NETORG5099798.onmicrosoft.com;dmarc=bestguesspass action=none
 header.from=mts-iss.com;compauth=pass reason=109
Received-SPF: Pass (protection.outlook.com: domain of mts-iss.com designates
 205.220.189.246 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.189.246; helo=dispatch1-usg1.ppe-hosted.com; pr=C
Received: from dispatch1-usg1.ppe-hosted.com (205.220.189.246) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Mon, 18 Nov 2024 20:08:57 +0000
Received: from m0423599.ppops.net (unknown [10.241.172.244])
	by dispatch1-usg1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 377E220097;
	Mon, 18 Nov 2024 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mts-iss.com;
 h=cc:cc:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1729026303; bh=SgMJVUhhH9FF7hypY9l25M4JfyPl/5d4r+pqNT/h+lA=;
 b=c4Xeeab5adsN4kHymlTAzbq/cNuuGbZdYjCaC7DR7sWRzsUuCBTqNrpox2lab4QrM8/bNOL0YOyoFKPVUIheB+LI9RdLQkmOKTFFrCiL4gTJP7Yzay/fwFybUK7P7LsOMjDNsy2AGFwXDxYgHenmN2aCw15rwTXFSeJVoJZMxt/GWbij8LALq9CpRUpTVvKzrGLJbvpS0k7AEwi0fgEsRLyFQAwHGWNLEyf9peg86LMpOP87jkC8+qMgeoZHNi6IYp5Oz8UI9sU7uEHk6wCw58CjXp+aqIlsLBbkKw00RGPr5kuLgRagMAQRfcpEl92tvlxS5KhYPiG4j6q3x5WqqQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-usg1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 61DE714005F;
	Mon, 18 Nov 2024 20:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTVydWX+5uqIzmNMPHCf4xEicM56RWG322SfVjBDUu2XHYLUEOucS80v5HtR72Hds0hJruKeX+SNaTJBDW2ZQNnDSeeVf8THv/mMxfzY50quZ0qz/nKMFieNO+2BC5k0H/oDkDcySi3IZbP1u/TIM4Jpq3pZFZoaN1eeWsvLC14gNZQpk9i192FlA/qh5G/HEKWu+x8Iw+LCfrxAFbrysmjltUgOeQRR8146g/g1hBMR3/zR2lvOc7dWVu1pF70bKFnzTPcqP7msKFEkBVtMeVA/OMPi0LrSywTzEWUdb7grFl5yw+j+K6sQb+sQrR+sDz8mnV1bA2510b0dZZp4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgMJVUhhH9FF7hypY9l25M4JfyPl/5d4r+pqNT/h+lA=;
 b=taDYHkngPI99Vzu5M5hIV5CtIsCTx832wuNLM7Os3N1ANZu/aJt/g6sIshKrp7fkftwKTDFQHC60zPmSqT6P0NH1l36GlT1rZtoOKdARnn2LQ8JEom/P8AlI7JlofW4I7xkw9drvm6UdegiAP6sXm1PXRLwhnj11ufETfz+5/t7wSdsTYgBfDUqKUzVD8MVCEQRFY0UsD1f0FE8pt85Ej6s2NrKrvIqhzjLX9ksz8hW6st39LTrdmfBdUFAPiiEqd/NYRTiHLAUKkhzZp0HRSXFqWLNisRTKjy9AMSrlNymZb3atPI7Ez9FuBQCpyvC7vsnE8h2Got2H16w+wHjuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mts-iss.com; dmarc=pass action=none header.from=mts-iss.com;
 dkim=pass header.d=mts-iss.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5099798.onmicrosoft.com; s=selector1-NETORG5099798-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgMJVUhhH9FF7hypY9l25M4JfyPl/5d4r+pqNT/h+lA=;
 b=LF7OIQwo8zjd8sCU7NG7h4W3tLHGgOLmJpahykQ+o8Oe4vwwI16A6mvhdAMHsNIpv1oo7/flKiiBAlHlkWuJkRryk1IwVuMhPuQl3LxrGl1yA/2jTJ81PwA2fhuwQ1dNATgczvaiNdiiLUA3ROkAEk8++uT3JXjG17w4DmnKSEo=
Received: from DM6PR08MB5580.namprd08.prod.outlook.com (2603:10b6:5:10f::27)
 by BN0PR08MB7535.namprd08.prod.outlook.com (2603:10b6:408:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 20:08:52 +0000
Received: from DM6PR08MB5580.namprd08.prod.outlook.com
 ([fe80::6b83:cde9:52cc:3a38]) by DM6PR08MB5580.namprd08.prod.outlook.com
 ([fe80::6b83:cde9:52cc:3a38%6]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 20:08:52 +0000
From: jimmy.murphy <jimmy.murphy@mts-iss.com>
To: VINCENT BRIFFA <VINCENT.BRIFFA@ebnet.org>
CC: JOE NESCI <JNESCI@ebnet.org>, rob.merchant mts-iss.com
	<rob.merchant@mts-iss.com>
Subject: Re: Server Reboots - BIOS Update
Thread-Topic: Server Reboots - BIOS Update
Thread-Index: Ads1Q3wvprXtKdWEQzWkwK4Woxz4GgErjTNAAADvKKw=
Date: Mon, 18 Nov 2024 20:08:51 +0000
Message-ID:
 <DM6PR08MB5580C8857D44E808858A2303C4272@DM6PR08MB5580.namprd08.prod.outlook.com>
References:
 <PH7PR11MB8600EFCEC1F2840D2DB3F0FD8D592@PH7PR11MB8600.namprd11.prod.outlook.com>
 <PH7PR11MB860060E43AB9AB4934F284A28D272@PH7PR11MB8600.namprd11.prod.outlook.com>
In-Reply-To:
 <PH7PR11MB860060E43AB9AB4934F284A28D272@PH7PR11MB8600.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mts-iss.com;
x-ms-traffictypediagnostic:
 DM6PR08MB5580:EE_|BN0PR08MB7535:EE_|BL02EPF00029927:EE_|DS0PR11MB8134:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c41658-597c-443a-0e51-08dd080cd5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|8096899003|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?F69fV5yMSt7IH/Vph7csxpCw3GihmXPvTBVkypyBPQ5BseZaXr0gut5yEkjw?=
 =?us-ascii?Q?hNTgamoje6XASWb9UqiKpgTw85ENGLy69RBml3qj0cKDc5OQkda8u8OVZb+z?=
 =?us-ascii?Q?K2biTg8/q3oNxsaQT65U5ss5EMW5mtO1mCPP74zb6q3VdKRzVQVYlAPTGxsJ?=
 =?us-ascii?Q?wn4/bF3ey6snsbA6dKl7Hz/LGpXxYyWCFbSBHHzJCTRJeUE+uyqCqtrt5FRR?=
 =?us-ascii?Q?TOBZD1bE8yHW+Qnl+OopcLVEX1IQB75xZgx1WcMNLWbKQf61Tk5r/aDVvMb3?=
 =?us-ascii?Q?8FjVJaPG0WYJihgOIMpjEZrq9V/JRPF5OAh+M/bhGIadxisUOb2xiNHsOGhU?=
 =?us-ascii?Q?KSLt18ro2xwM/wBJovIcnY6H/FSwRf2yPiiVGj6aNzIMk3S1Q43JRJQNr8p+?=
 =?us-ascii?Q?9DaPMGzYXkF/pC2fUvRRlKllWEyrH9xH0eH+eErzNd3NJ/2Vpn9DiCl7h85q?=
 =?us-ascii?Q?oMBP1paViDel3yT/Dai6Za7YI2ouuvuYTUHErOfC4LryliH/d2qxnvVLyaen?=
 =?us-ascii?Q?uv2EnONj5bapCOL/YW3FIWwxJHpysBKJemWV61SG4/ex1sz5D/YX4v3nBZ+l?=
 =?us-ascii?Q?UWSBuZMMmnInCEu4+XI6/UAOQiBfBad4RKvBYSnO2hBlDys+dzo0IMBB3Aag?=
 =?us-ascii?Q?WTw87IlR+h2QTcTFST0m9tqZGV2/r8o5bPbw6kIBOOXosPLVNWdJxzgnG+DW?=
 =?us-ascii?Q?dfMiut6I9teNTYR19OXgQtiUz9FHbPhzHnUZA7+F4KArzr89sFpKmoJylmvX?=
 =?us-ascii?Q?aeZn4t4blX81/RdWg2KgnqYJaBv4GLfFWd8saGI44AE5qZPdW//dNjB4f5kO?=
 =?us-ascii?Q?vWr/PZjqGjcpDVqeqkQmy5qRMiAYpIEGrk/A7toeMaexey8GZfSfQZ+CnfbJ?=
 =?us-ascii?Q?GHGazeTMWXt1T/maymttso84TxM6Nu+3rsF/HX7PU0XzUU2Ef5wfRNCsfpJs?=
 =?us-ascii?Q?3Hb1IdWk6e12+9X8gyiSFg02xbASQnd5LEHp+06jwLw/DFFwK3Fd8Ja4u+s8?=
 =?us-ascii?Q?mE9OxiyL2dx5N2vSRzXIwy+FV/C2ojvD29+hhLOSmgtPVLExPSME/mvDdViL?=
 =?us-ascii?Q?STaaYZQXcIP4kzzT8vHA16U4jPDHCL6wLhgDhu9KbRRPgHUQk7uuq+hzuG8F?=
 =?us-ascii?Q?pJwUfT2TntdCTRoSWve6pwyJjWfO+ZCHWbr5tUywUTlJpkpI9yr+8c61n7li?=
 =?us-ascii?Q?BVr0GMh/kq+tQscySEN0vZalNw1VMSj6WaBHohuTiQH70m9P596deFBiHdUN?=
 =?us-ascii?Q?rgRbz4907mPgQoLdBfWXr5Or26SwRRKZfdrpgye6xi12VDKGRyueAVH8+S9M?=
 =?us-ascii?Q?RIDQgZAIkftzluAB+flwWP2D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR08MB5580.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-Original-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-Original-0:
 =?us-ascii?Q?H52cU3gbmCKuyophJfKlXQiRxjguAfCWzUEzMIrPP6XPip3B+4YFs+ZBlg1B?=
 =?us-ascii?Q?2CJilpMBuap6sZonkkau8NPPPtr+2rZ6GB5/Bc5UTWQVLEXhnorOfrd+bhTs?=
 =?us-ascii?Q?9Cnk1xF5khOi3I/noJGK3At8+Z9eOeHbDdk3zsIdHIpxTSk6jtyiu9+iAUeO?=
 =?us-ascii?Q?2z+jkOr3sxWVlF2pjh3emyyjISZzJy4wFugmLQG60CkYDAoXT395fu7ZFIXc?=
 =?us-ascii?Q?XbsQo4ZZTcy7btPJ0h/zOr/JiglMd4yIW/yOiQywsfcsz/StLnx0/HAH3ZBQ?=
 =?us-ascii?Q?n1rmmY6pAeN162bw33HVtXNAv9iiUln4b07XG5LSxzpgSaeoJ9Q6y+UNGeqi?=
 =?us-ascii?Q?hnJ1HDX/g1Hj7ocdTX1kXvRDA7t1oZHqyFQ47K8U7UP5eu9oH45VZSb4YFAC?=
 =?us-ascii?Q?4XnAcEdlpUfcg2rIinte6HvpsPJzrn8hgQOe0vVF3Lfs/m7VyCdTcR31yNxp?=
 =?us-ascii?Q?r7d0MJ52d8opgkq9wE8UAUC7q40T4U1fqZJDK47RRKbHdkb9lTMgWt5jzfdi?=
 =?us-ascii?Q?t3bfR5nt9U1S7yHo3gWaOs2viaSMKyYHIo8ldRpiXcGVkla07UVckysjNGjS?=
 =?us-ascii?Q?xkFKxDec0o9D4mL8chF3yUJzY6BM5+f/SCpnMA0OneMML27fZodlRuKD0FGy?=
 =?us-ascii?Q?vqhtfAfyUh6e8wT8Ne6xuWVjx5klXzu2GS5AAFcClfwuPQl/RK9Aha7qHpzT?=
 =?us-ascii?Q?vyHpSoo4jiThLJgc0BJB8FBnbj7TbpVOf5ELhKKU7czBYXdjx6GtMAQBSSST?=
 =?us-ascii?Q?xlJ+i8Y48afcsBD5HPDPOmIAnobGxaQjewd/4sbMVISfGl3LnAt6WwX3iX6E?=
 =?us-ascii?Q?vZWAIeTHU1//WXUTzNNPpyNXoD4ieSIfkWNCgZiArfNyQ3kaaRYgJlbIigYc?=
 =?us-ascii?Q?UFNdk1s8lG/WTls3D4OCEVaGStLcfgYaY1SOtnd2HcHJBMfipBOF0/eqJ77B?=
 =?us-ascii?Q?7tRaSBmKEUUUrmpO9gaQ85dwVfLbget7U0sXFv0CpHD3OSJlZR2hURD5MUf4?=
 =?us-ascii?Q?Ch/G+nLgZgte6C1Fnjm/YvqXotkmKY3asnhyVKexbIEiOPXltlFSplNET4BK?=
 =?us-ascii?Q?0KVt12KrSj82AkX2s4IUgYlvk311c4Moe/1wyeamwGgMQZ2gw2fjbIZ8zdP/?=
 =?us-ascii?Q?wmuKOLw4Kl9Ixk5u2X1q3MiObMn1wwak2M37UQHganpH++kzlmD4VVCMOFiK?=
 =?us-ascii?Q?lTP1isgmdQuN27bKPgErlYAFspG5uosqCCg0z69M0ybV5EtSlV4xPS0YbnHc?=
 =?us-ascii?Q?0p9eDoT6PVKlLUM8b6d2rtxFJOpbntVd6jhmxUHFlujdUJ0OfcY5RZZ6X+pP?=
 =?us-ascii?Q?mP+3xlnJUyy7svTwRxtHmIgPAJMyZSN6i/xsNveg8h55o3rts5pIgBMmwgTx?=
 =?us-ascii?Q?qTOzLfKIvsZJGqn6gN5x32RahLgoCQKNdqLB3aBAgG2v0KXjP53Du7AHwJ+8?=
 =?us-ascii?Q?Cb+5mfas5v++D4f6xk25MWyi7KrpjpPYqo8SXSJGgrf9bzqZsv46YNr/Iakr?=
 =?us-ascii?Q?FVy/uphkEasiSiDlIxcDA8JWX+VwYgQR3zi7Yd7MSEBebhAar2/hxDXSu+ci?=
 =?us-ascii?Q?KHs5lFnKswnFmDExMhjQw0Khwyp1jRa/vbBoriBAKHmqNwjSdr2vBzYu29cD?=
 =?us-ascii?Q?3Laf6mjlyPvYrpifufwit9Psm73kKYcNsFN3U4pkk3ww?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR08MB5580C8857D44E808858A2303C4272DM6PR08MB5580namp_"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR08MB7535
X-MDID: 1731960537-ChNjuDuxucJc
X-MDID-O:
 usg1;us-east-1f;1731960537;ChNjuDuxucJc;<jimmy.murphy@mts-iss.com>;1cac9f66a82f36af007cfbe806277bac
X-PPE-TRUSTED: V=1;DIR=OUT;
Return-Path: jimmy.murphy@mts-iss.com
X-MS-Exchange-Organization-ExpirationStartTime: 18 Nov 2024 20:08:57.8125
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id:
 d6c41658-597c-443a-0e51-08dd080cd5ec
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: e43e2deb-27ef-4506-820e-abff7ea910d8:0
X-MS-Exchange-Organization-MessageDirectionality: Incoming
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BL02EPF00029927.namprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Exchange-Organization-AuthSource:
 BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 3fe41dd1-03f1-488b-1b0f-08dd080cd271
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Antispam: BCL:0;ARA:13230040|35042699022|8096899003;
X-Forefront-Antispam-Report:
 CIP:205.220.189.246;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:dispatch1-usg1.ppe-hosted.com;PTR:dispatch1-usg1.ppe-hosted.com;CAT:NONE;SFS:(13230040)(35042699022)(8096899003);DIR:INB;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:08:57.7031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c41658-597c-443a-0e51-08dd080cd5ec
X-MS-Exchange-CrossTenant-Id: e43e2deb-27ef-4506-820e-abff7ea910d8
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-MS-Exchange-Transport-EndToEndLatency: 00:00:05.6904397
X-MS-Exchange-Processed-By-BccFoldering: 15.20.8158.013
X-Microsoft-Antispam-Mailbox-Delivery:
	ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(930097)(140003)(1420198);
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wTzr/nd56FfKKTy1ssepLtDruHjL1v5XiYR7D5Lm3uJ/g2qhD9PpivAEsRlE?=
 =?us-ascii?Q?5eyd689JZcbLpb8TZJhm1Igiws2ol7lG+RjmSOEqRLwuPEhjAkkTrfbBAAOi?=
 =?us-ascii?Q?CiTbx2AUovZvVnbGNkfLwj50XYFfohakC74RnYpgYK8b2VT90qGllOqwdog/?=
 =?us-ascii?Q?xORkza590Yx0EUI5CkSYFMNntxrF9vzVGIkJnv7ketFdJIcPf+E+SeC0hLBi?=
 =?us-ascii?Q?VgRSu5xj714vpJIJxdL9BvKCXBsF9s6Al0cyu6wReZOo67bd6uyZiZGDaCt5?=
 =?us-ascii?Q?V5RsTJlVSlKxzj6cbDt09Mfb/j5Gyw35sbTf91wEad9nVuh3OO0x8VID2Fcx?=
 =?us-ascii?Q?vSDUjOe5qPLK/olHHtaWMZbwAYu13EA5uBc7Z5a0aik6Oi/imXlDk6lJfKPI?=
 =?us-ascii?Q?KSJr0ScLGCXwchckROhInKIqA2cmuUSNDWPnvTENVdhJ37iwhDXcAzgfgS8J?=
 =?us-ascii?Q?VZjtNPKiOeVKyOQuDHXNEqugdEkMUB1yt76NmDtoUH07XdqglNZ1cq67jvJX?=
 =?us-ascii?Q?tBzvUEU7QkVGQiAYxWcnUlknM9r3xOvQF/K2qKCo1iPKGjepNiuf5sr937YG?=
 =?us-ascii?Q?dGNFcaMVaZVGVBG2e5QjC6UVONZ+toCouCfRnbs41DidFUQp0aA0sxXFMNe7?=
 =?us-ascii?Q?Qq2HZ1S9AiSJIeYl2x+UajFFJzB5uHYV/P01U0T9aazqCS/mdhpZY1kYOZcB?=
 =?us-ascii?Q?Ys9qNlApzjZjYLljwpJtWrngWH5DA/tgIRPrTL1zIG5WQ/0uFs/L6WpIPG3P?=
 =?us-ascii?Q?UMN4Iz4TRgO0kj13k5o01J0XuaqEBKk5AHT8tJHgym+LP9oelq5295EAvwQ3?=
 =?us-ascii?Q?43iYFlFb0uOnoIykueIB32r4T/3YY3974l1UU/dvUzRD/zvkfIlPZIDnQX+F?=
 =?us-ascii?Q?dCawCkYBlaJzQ18I2Lx5ZLzwAMmQje382IMRUVQzBq0I5S0WB7k2gRxxLkgI?=
 =?us-ascii?Q?bXj3UjZg8i75uUlXnGIOxBIR8e3xlf7C+A9iXFC2Dn3B0T6YSQQ66qO2ucw7?=
 =?us-ascii?Q?TKF+u6PQR1qd4wN3M5gaIUMjXLQulRgYi5g40+esnbcpSOIjxoJ//liI71Jy?=
 =?us-ascii?Q?CaKP3KXhmmsbRUHoXII4H6ul/aKsLNgyHu/FEkNS7HDRYIo8t9Y2FrYqs5XS?=
 =?us-ascii?Q?l73RgG/UfgBWjX+mrCzJP5gJaVrA+AvQ5LvwdP0Fo+QgnlazvIX/0LnFJUNQ?=
 =?us-ascii?Q?trs9FT3E3Nm9aB1CLSaulnbw/c4q4wp0lUO6RfnO52Y1soPT409Wskl/8aTu?=
 =?us-ascii?Q?YH+/YpI9SKB1mSI9sSQ9lUw04Bd4kU/3YcfNyctJijRIiFrBokxFrtUlh0J5?=
 =?us-ascii?Q?ucVDEa5n+T5dRhzQzjiYzMnmXCYL3eteL+lTK4ZchzYJA95M4E6m94DmPVyZ?=
 =?us-ascii?Q?1QtTrhbqDRVPtEsZKMkEYRCReuTyoBPe/gRR/mRX5XrJvsHooHNgbgjEmjE6?=
 =?us-ascii?Q?9vW16WKszvOoAe4B+OYLcD2PnHpPPkRUlPtwxJMMNlvbcaPYsLYu9iGhvfGc?=
 =?us-ascii?Q?wH3X5NiDbMvGiBSPykpurFN9vr9WiTmQTZnZ+SZBc+uMlP6ccFMqT2Xm6ilp?=
 =?us-ascii?Q?s+bIe9brxilKVt7dw1Dg181AjsXoiDLuBMi4Bc8MZhpTQn1e+VZOtC7d0Kem?=
 =?us-ascii?Q?4jw7E8ed6JNOtzkgKTfZTwJkfE6DCBCuBKqdFDJT3yPRiXZX0VvFUmwJtvRk?=
 =?us-ascii?Q?uKxfK5li7VKFf/HW46X3777SP3A4CDAlVl/xZNB2UGSE/zItJZcXq8LB9Aym?=
 =?us-ascii?Q?QoqNQ6IPCgF+My+QdpuRObDnZ4vf7qSJWogjWpE+03+tdVDGFHLr?=
