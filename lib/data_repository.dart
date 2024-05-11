import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> importRegions() async {
  final regionsData = [
  {
    'shapeName': 'Nefas Silk',
    'shapeID': '50319843B19699273149203'
  },
  {
    'shapeName': 'Bole',
    'shapeID': '50319843B86708066346631'
  },
  {
    'shapeName': 'Lideta',
    'shapeID': '50319843B15782966735816'
  },
  {
    'shapeName': 'Kirkos',
    'shapeID': '50319843B51826241892451'
  },
  {
    'shapeName': 'Yeka',
    'shapeID': '50319843B46187477476617'
  },
  {
    'shapeName': 'Addis Ketema',
    'shapeID': '50319843B12584916837481'
  },
  {
    'shapeName': 'Arada',
    'shapeID': '50319843B51479790407772'
  },
  {
    'shapeName': 'Gulele',
    'shapeID': '50319843B44051004369137'
  },
  {
    'shapeName': 'Adwa',
    'shapeID': '50319843B45174556297539'
  },
  {
    'shapeName': 'Ahferom',
    'shapeID': '50319843B88286339392714'
  },
  {
    'shapeName': 'Alaje',
    'shapeID': '50319843B3847479979158'
  },
  {
    'shapeName': 'Alamata',
    'shapeID': '50319843B41420556628051'
  },
  {
    'shapeName': 'Asgede Tsimbila',
    'shapeID': '50319843B12169789289947'
  },
  {
    'shapeName': 'Atsbi Wenberta',
    'shapeID': '50319843B9776756696877'
  },
  {
    'shapeName': 'Degua Temben',
    'shapeID': '50319843B46532526980147'
  },
  {
    'shapeName': 'Enderta',
    'shapeID': '50319843B57027491323981'
  },
  {
    'shapeName': 'Erob',
    'shapeID': '50319843B42536966424639'
  },
  {
    'shapeName': 'Ganta Afeshum',
    'shapeID': '50319843B61292035785785'
  },
  {
    'shapeName': 'Gulomekeda',
    'shapeID': '50319843B21009106887943'
  },
  {
    'shapeName': 'Hawzen',
    'shapeID': '50319843B42325933614474'
  },
  {
    'shapeName': 'Hintalo Wejirat',
    'shapeID': '50319843B93494791160987'
  },
  {
    'shapeName': 'Kafta Humera',
    'shapeID': '50319843B59136253771422'
  },
  {
    'shapeName': 'Kelete Awelallo',
    'shapeID': '50319843B19649950251646'
  },
  {
    'shapeName': 'Kola Temben',
    'shapeID': '50319843B59140307889365'
  },
  {
    'shapeName': 'Laelay Adiyabo',
    'shapeID': '50319843B73539252367372'
  },
  {
    'shapeName': 'Laelay Maychew',
    'shapeID': '50319843B60996594322254'
  },
  {
    'shapeName': 'Medebay Zana',
    'shapeID': '50319843B22500266858902'
  },
  {
    'shapeName': 'Mereb Leke',
    'shapeID': '50319843B25239495539821'
  },
  {
    'shapeName': 'Naeder Adet',
    'shapeID': '50319843B1044465376644'
  },
  {
    'shapeName': 'Ofla',
    'shapeID': '50319843B13358118619992'
  },
  {
    'shapeName': 'Saesie Tsaedaemba',
    'shapeID': '50319843B10420247538519'
  },
  {
    'shapeName': 'Saharti Samre',
    'shapeID': '50319843B82812773717171'
  },
  {
    'shapeName': 'Tahtay Adiyabo',
    'shapeID': '50319843B14236527246645'
  },
  {
    'shapeName': 'Tahtay Koraro',
    'shapeID': '50319843B41406481840211'
  },
  {
    'shapeName': 'Tahtay Maychew',
    'shapeID': '50319843B83735069604460'
  },
  {
    'shapeName': 'Tanqua Abergele',
    'shapeID': '50319843B9816904534364'
  },
  {
    'shapeName': 'Tsegede',
    'shapeID': '50319843B21406969134358'
  },
  {
    'shapeName': 'Tselemti',
    'shapeID': '50319843B80163549873819'
  },
  {
    'shapeName': 'Welkait',
    'shapeID': '50319843B71495506443053'
  },
  {
    'shapeName': 'Werei Leke',
    'shapeID': '50319843B49024740271646'
  },
  {
    'shapeName': 'Endamehoni',
    'shapeID': '50319843B23350595116444'
  },
  {
    'shapeName': 'Raya Azebo',
    'shapeID': '50319843B69548424255360'
  },
  {
    'shapeName': 'Ayisha',
    'shapeID': '50319843B68909235900220'
  },
  {
    'shapeName': 'Erer',
    'shapeID': '50319843B57695875018793'
  },
  {
    'shapeName': 'Afdem',
    'shapeID': '50319843B6640304084377'
  },
  {
    'shapeName': 'Shinile',
    'shapeID': '50319843B40794925609232'
  },
  {
    'shapeName': 'Dire Dawa/Town',
    'shapeID': '50319843B26385279935816'
  },
  {
    'shapeName': 'Aw-bare',
    'shapeID': '50319843B30413627047798'
  },
  {
    'shapeName': 'Dembel',
    'shapeID': '50319843B64703595769147'
  },
  {
    'shapeName': 'Miesso',
    'shapeID': '50319843B53021067306174'
  },
  {
    'shapeName': 'Jijiga',
    'shapeID': '50319843B12498417610384'
  },
  {
    'shapeName': 'Dire Dawa',
    'shapeID': '50319843B73919707038884'
  },
  {
    'shapeName': 'Kebribeyah',
    'shapeID': '50319843B26378393771849'
  },
  {
    'shapeName': 'Hareshen',
    'shapeID': '50319843B30008338586587'
  },
  {
    'shapeName': 'Harar',
    'shapeID': '50319843B64501891470449'
  },
  {
    'shapeName': 'Gursum',
    'shapeID': '50319843B19836820319618'
  },
  {
    'shapeName': 'Dihun',
    'shapeID': '50319843B11804393399224'
  },
  {
    'shapeName': 'Geladin',
    'shapeID': '50319843B12318157217945'
  },
  {
    'shapeName': 'Babile',
    'shapeID': '50319843B9872708790585'
  },
  {
    'shapeName': 'Degehabur',
    'shapeID': '50319843B18884321825919'
  },
  {
    'shapeName': 'Gashamo',
    'shapeID': '50319843B43064236532886'
  },
  {
    'shapeName': 'Degehamedo',
    'shapeID': '50319843B82723034040872'
  },
  {
    'shapeName': 'Danot',
    'shapeID': '50319843B19790127910727'
  },
  {
    'shapeName': 'Fik',
    'shapeID': '50319843B36497823934955'
  },
  {
    'shapeName': 'Boh',
    'shapeID': '50319843B48966497561399'
  },
  {
    'shapeName': 'Hamero',
    'shapeID': '50319843B33445821978279'
  },
  {
    'shapeName': 'Segeg',
    'shapeID': '50319843B6955564473838'
  },
  {
    'shapeName': 'Gerbo',
    'shapeID': '50319843B51903171422186'
  },
  {
    'shapeName': 'Shekosh',
    'shapeID': '50319843B23170385114361'
  },
  {
    'shapeName': 'Warder',
    'shapeID': '50319843B42952502108963'
  },
  {
    'shapeName': 'Kebridehar',
    'shapeID': '50319843B11229146994934'
  },
  {
    'shapeName': 'Shilabo',
    'shapeID': '50319843B83571276366092'
  },
  {
    'shapeName': 'Goro Baqaqsa',
    'shapeID': '50319843B75604403112810'
  },
  {
    'shapeName': 'Serer/Elkere',
    'shapeID': '50319843B97772591444395'
  },
  {
    'shapeName': 'Debeweyin',
    'shapeID': '50319843B34071313144835'
  },
  {
    'shapeName': 'Gode',
    'shapeID': '50319843B1969119585855'
  },
  {
    'shapeName': 'Kelafo',
    'shapeID': '50319843B75528043221614'
  },
  {
    'shapeName': 'Mustahil',
    'shapeID': '50319843B45853724496675'
  },
  {
    'shapeName': 'Bare',
    'shapeID': '50319843B33427512840295'
  },
  {
    'shapeName': 'Chereti/Weyib',
    'shapeID': '50319843B70551012158294'
  },
  {
    'shapeName': 'Ferfer',
    'shapeID': '50319843B21694903684271'
  },
  {
    'shapeName': 'Afder',
    'shapeID': '50319843B28717382610021'
  },
  {
    'shapeName': 'Dolobay',
    'shapeID': '50319843B63921406264277'
  },
  {
    'shapeName': 'Moyale',
    'shapeID': '50319843B49393310235770'
  },
  {
    'shapeName': 'Dolo Odo',
    'shapeID': '50319843B98049702667105'
  },
  {
    'shapeName': 'Lagahida',
    'shapeID': '50319843B92447135269151'
  },
  {
    'shapeName': 'Meyumuluka',
    'shapeID': '50319843B51635089338537'
  },
  {
    'shapeName': 'Selahad',
    'shapeID': '50319843B97730757572151'
  },
  {
    'shapeName': 'Guradamole',
    'shapeID': '50319843B75864783804447'
  },
  {
    'shapeName': 'West Imi',
    'shapeID': '50319843B57833931439756'
  },
  {
    'shapeName': 'Adadle',
    'shapeID': '50319843B45001987620761'
  },
  {
    'shapeName': 'Hudet',
    'shapeID': '50319843B17051665198208'
  },
  {
    'shapeName': 'Filtu',
    'shapeID': '50319843B77301140128180'
  },
  {
    'shapeName': 'East Imi',
    'shapeID': '50319843B31082163957868'
  },
  {
    'shapeName': 'Denan',
    'shapeID': '50319843B88110363130967'
  },
  {
    'shapeName': 'Gunagado',
    'shapeID': '50319843B91665049149688'
  },
  {
    'shapeName': 'Aware',
    'shapeID': '50319843B61581034659573'
  },
  {
    'shapeName': 'Wantawo',
    'shapeID': '50319843B93878095723904'
  },
  {
    'shapeName': 'Akobo',
    'shapeID': '50319843B95422220538871'
  },
  {
    'shapeName': 'Jikawo',
    'shapeID': '50319843B67583852469467'
  },
  {
    'shapeName': 'Lare',
    'shapeID': '50319843B97724480478908'
  },
  {
    'shapeName': 'Gambella Wild Life Reserve',
    'shapeID': '50319843B20083271692133'
  },
  {
    'shapeName': 'Itang',
    'shapeID': '50319843B17667988658538'
  },
  {
    'shapeName': 'Gambela Zuria',
    'shapeID': '50319843B76074615288353'
  },
  {
    'shapeName': 'Jore',
    'shapeID': '50319843B93237477801108'
  },
  {
    'shapeName': 'Abobo',
    'shapeID': '50319843B55091318037010'
  },
  {
    'shapeName': 'Gog',
    'shapeID': '50319843B11228053874472'
  },
  {
    'shapeName': 'Mengesh',
    'shapeID': '50319843B40579531478010'
  },
  {
    'shapeName': 'Godere',
    'shapeID': '50319843B63152238667752'
  },
  {
    'shapeName': 'Dima',
    'shapeID': '50319843B72289310933001'
  },
  {
    'shapeName': 'Guba',
    'shapeID': '50319843B91539473104167'
  },
  {
    'shapeName': 'Pawe Special',
    'shapeID': '50319843B7254620757427'
  },
  {
    'shapeName': 'Dangura',
    'shapeID': '50319843B32498161547062'
  },
  {
    'shapeName': 'Mandura',
    'shapeID': '50319843B66429210471549'
  },
  {
    'shapeName': 'Dibat',
    'shapeID': '50319843B93462300754915'
  },
  {
    'shapeName': 'Bulen',
    'shapeID': '50319843B82083096744984'
  },
  {
    'shapeName': 'Yaso',
    'shapeID': '50319843B13275567243070'
  },
  {
    'shapeName': 'Wenbera',
    'shapeID': '50319843B82504025234031'
  },
  {
    'shapeName': 'Bio Jiganifado',
    'shapeID': '50319843B61358171562004'
  },
  {
    'shapeName': 'Kamashi',
    'shapeID': '50319843B70912542057437'
  },
  {
    'shapeName': 'Agalometi',
    'shapeID': '50319843B30246244858060'
  },
  {
    'shapeName': 'Bio Jiganifado',
    'shapeID': '50319843B309402659693'
  },
  {
    'shapeName': 'Sirba Abay',
    'shapeID': '50319843B50566638778178'
  },
  {
    'shapeName': 'Bilidigilu',
    'shapeID': '50319843B29927389810070'
  },
  {
    'shapeName': 'Sherkole',
    'shapeID': '50319843B83548344471006'
  },
  {
    'shapeName': 'Menge',
    'shapeID': '50319843B53734355804333'
  },
  {
    'shapeName': 'Homosha',
    'shapeID': '50319843B63557261683049'
  },
  {
    'shapeName': 'Kurmuk',
    'shapeID': '50319843B12700849517490'
  },
  {
    'shapeName': 'Assosa',
    'shapeID': '50319843B69035237459256'
  },
  {
    'shapeName': 'Maokomo Special',
    'shapeID': '50319843B55236923861221'
  },
  {
    'shapeName': 'Bambasi',
    'shapeID': '50319843B72892965378847'
  },
  {
    'shapeName': 'Debub Achefer',
    'shapeID': '50319843B73839663492066'
  },
  {
    'shapeName': 'Albuko',
    'shapeID': '50319843B8345534319365'
  },
  {
    'shapeName': 'Alfa',
    'shapeID': '50319843B76870767190274'
  },
  {
    'shapeName': 'Ambasel',
    'shapeID': '50319843B57636603364378'
  },
  {
    'shapeName': 'Aneded',
    'shapeID': '50319843B63587664379927'
  },
  {
    'shapeName': 'Angolelana Tera',
    'shapeID': '50319843B2842312809181'
  },
  {
    'shapeName': 'Ankasha',
    'shapeID': '50319843B57472884903422'
  },
  {
    'shapeName': 'Ankober',
    'shapeID': '50319843B5411080979194'
  },
  {
    'shapeName': 'Antsokiya',
    'shapeID': '50319843B65745735982567'
  },
  {
    'shapeName': 'Argoba',
    'shapeID': '50319843B1461345340795'
  },
  {
    'shapeName': 'Assagirt',
    'shapeID': '50319843B42126087782118'
  },
  {
    'shapeName': 'Awabel',
    'shapeID': '50319843B54371861415989'
  },
  {
    'shapeName': 'Bahirdar Zuria',
    'shapeID': '50319843B55511373526936'
  },
  {
    'shapeName': 'Banja',
    'shapeID': '50319843B34907337264310'
  },
  {
    'shapeName': 'Baso Liben',
    'shapeID': '50319843B92765917578553'
  },
  {
    'shapeName': 'Bati',
    'shapeID': '50319843B89894017056595'
  },
  {
    'shapeName': 'Berehet',
    'shapeID': '50319843B98663124355322'
  },
  {
    'shapeName': 'Beyeda',
    'shapeID': '50319843B46998817577536'
  },
  {
    'shapeName': 'Bibugn',
    'shapeID': '50319843B7778346664594'
  },
  {
    'shapeName': 'Bugna',
    'shapeID': '50319843B79777676316907'
  },
  {
    'shapeName': 'Bure',
    'shapeID': '50319843B56011033939457'
  },
  {
    'shapeName': 'Dewa Cheffa',
    'shapeID': '50319843B11042909162301'
  },
  {
    'shapeName': 'Chilga',
    'shapeID': '50319843B57330424452483'
  },
  {
    'shapeName': 'Dabat',
    'shapeID': '50319843B44080278449711'
  },
  {
    'shapeName': 'Dangila',
    'shapeID': '50319843B61664907133556'
  },
  {
    'shapeName': 'Dawunt',
    'shapeID': '50319843B15562041515616'
  },
  {
    'shapeName': 'Debark',
    'shapeID': '50319843B72812680708829'
  },
  {
    'shapeName': 'Debay Telatgen',
    'shapeID': '50319843B68186040663543'
  },
  {
    'shapeName': 'Debre Elias',
    'shapeID': '50319843B79466164048030'
  },
  {
    'shapeName': 'Debresina',
    'shapeID': '50319843B17662247057898'
  },
  {
    'shapeName': 'Dega Damot',
    'shapeID': '50319843B38995186444673'
  },
  {
    'shapeName': 'Dehana',
    'shapeID': '50319843B60599428841602'
  },
  {
    'shapeName': 'Dejen',
    'shapeID': '50319843B27987561087912'
  },
  {
    'shapeName': 'Delanta',
    'shapeID': '50319843B84926059727443'
  },
  {
    'shapeName': 'Dembecha',
    'shapeID': '50319843B89002542762909'
  },
  {
    'shapeName': 'Dembia',
    'shapeID': '50319843B88652177755582'
  },
  {
    'shapeName': 'Dera',
    'shapeID': '50319843B99114047742137'
  },
  {
    'shapeName': 'Dessie Zuria',
    'shapeID': '50319843B82740725587335'
  },
  {
    'shapeName': 'East Esite',
    'shapeID': '50319843B5262740348176'
  },
  {
    'shapeName': 'East Belesa',
    'shapeID': '50319843B57561266145460'
  },
  {
    'shapeName': 'Ebenat',
    'shapeID': '50319843B38472754780748'
  },
  {
    'shapeName': 'Eferatana Gidem',
    'shapeID': '50319843B60253771840622'
  },
  {
    'shapeName': 'Enarj Enawga',
    'shapeID': '50319843B709031203716'
  },
  {
    'shapeName': 'Enbise Sar Midir',
    'shapeID': '50319843B30008396673454'
  },
  {
    'shapeName': 'Enemay',
    'shapeID': '50319843B75088158129957'
  },
  {
    'shapeName': 'Fagta Lakoma',
    'shapeID': '50319843B37077996235103'
  },
  {
    'shapeName': 'Farta',
    'shapeID': '50319843B94270413140839'
  },
  {
    'shapeName': 'Fogera',
    'shapeID': '50319843B24617819346111'
  },
  {
    'shapeName': 'Gaz Gibla',
    'shapeID': '50319843B32582855006525'
  },
  {
    'shapeName': 'Menz Gera Midir',
    'shapeID': '50319843B33094256826906'
  },
  {
    'shapeName': 'Gidan',
    'shapeID': '50319843B71389748748491'
  },
  {
    'shapeName': 'Gishe Rabel',
    'shapeID': '50319843B2464947370703'
  },
  {
    'shapeName': 'Goncha Siso Enese',
    'shapeID': '50319843B86948852648144'
  },
  {
    'shapeName': 'Gonder Zuria',
    'shapeID': '50319843B19733624083948'
  },
  {
    'shapeName': 'Gonje',
    'shapeID': '50319843B81588580857237'
  },
  {
    'shapeName': 'Guagusa Shikudad',
    'shapeID': '50319843B12476338608661'
  },
  {
    'shapeName': 'Guangua',
    'shapeID': '50319843B88182666240433'
  },
  {
    'shapeName': 'Guba Lafto',
    'shapeID': '50319843B74797425254295'
  },
  {
    'shapeName': 'Guzamn',
    'shapeID': '50319843B40595474070090'
  },
  {
    'shapeName': 'Habru',
    'shapeID': '50319843B9907024765732'
  },
  {
    'shapeName': 'Hagere Mariam',
    'shapeID': '50319843B87800515302121'
  },
  {
    'shapeName': 'Hulet Ej Enese',
    'shapeID': '50319843B92800207484367'
  },
  {
    'shapeName': 'Jabi Tehnan',
    'shapeID': '50319843B28406830927886'
  },
  {
    'shapeName': 'Jama',
    'shapeID': '50319843B53617938560379'
  },
  {
    'shapeName': 'Janamora',
    'shapeID': '50319843B14692339263776'
  },
  {
    'shapeName': 'Jawi',
    'shapeID': '50319843B36099953520998'
  },
  {
    'shapeName': 'Jille Timuga',
    'shapeID': '50319843B29249774307921'
  },
  {
    'shapeName': 'Kalu',
    'shapeID': '50319843B80221085980479'
  },
  {
    'shapeName': 'Kelela',
    'shapeID': '50319843B78643659415361'
  },
  {
    'shapeName': 'Kewet',
    'shapeID': '50319843B53649906678273'
  },
  {
    'shapeName': 'Menz Keya Gabriel',
    'shapeID': '50319843B95780598472106'
  },
  {
    'shapeName': 'Kutaber',
    'shapeID': '50319843B38892031153566'
  },
  {
    'shapeName': 'Lasta',
    'shapeID': '50319843B33546609021281'
  },
  {
    'shapeName': 'Lay Armacho',
    'shapeID': '50319843B19168448161314'
  },
  {
    'shapeName': 'Lay Gayint',
    'shapeID': '50319843B83564714844927'
  },
  {
    'shapeName': 'Legambo',
    'shapeID': '50319843B18580288960558'
  },
  {
    'shapeName': 'Legehida',
    'shapeID': '50319843B52252164662495'
  },
  {
    'shapeName': 'Libo Kemkem',
    'shapeID': '50319843B71921061126134'
  },
  {
    'shapeName': 'Mecha',
    'shapeID': '50319843B8062800221587'
  },
  {
    'shapeName': 'Mehal Sayint',
    'shapeID': '50319843B90359403094716'
  },
  {
    'shapeName': 'Mekdela',
    'shapeID': '50319843B60318438998645'
  },
  {
    'shapeName': 'Meket',
    'shapeID': '50319843B77287761278912'
  },
  {
    'shapeName': 'Menz Lalo Midir',
    'shapeID': '50319843B50423579094598'
  },
  {
    'shapeName': 'Menz Mama Midir',
    'shapeID': '50319843B34605653561801'
  },
  {
    'shapeName': 'Merahbete',
    'shapeID': '50319843B72647291256577'
  },
  {
    'shapeName': 'Metema',
    'shapeID': '50319843B10385391312658'
  },
  {
    'shapeName': 'Michakel',
    'shapeID': '50319843B40368985062491'
  },
  {
    'shapeName': 'Mimo Weremo',
    'shapeID': '50319843B74584788506136'
  },
  {
    'shapeName': 'Minjar Shenkora',
    'shapeID': '50319843B34717109926398'
  },
  {
    'shapeName': 'Mirab Armacho',
    'shapeID': '50319843B40646641165078'
  },
  {
    'shapeName': 'Mojan Wedera',
    'shapeID': '50319843B42993471614360'
  },
  {
    'shapeName': 'Moretna Jiru',
    'shapeID': '50319843B84842026132876'
  },
  {
    'shapeName': 'Quara',
    'shapeID': '50319843B43439774868073'
  },
  {
    'shapeName': 'Quarit',
    'shapeID': '50319843B64348001504977'
  },
  {
    'shapeName': 'Sahla',
    'shapeID': '50319843B28710425108864'
  },
  {
    'shapeName': 'Sayint',
    'shapeID': '50319843B34909588227847'
  },
  {
    'shapeName': 'Sekela',
    'shapeID': '50319843B63213074509356'
  },
  {
    'shapeName': 'Semen Achefer',
    'shapeID': '50319843B20128918521240'
  },
  {
    'shapeName': 'Senan',
    'shapeID': '50319843B83057564900620'
  },
  {
    'shapeName': 'Shebel Bereta',
    'shapeID': '50319843B21164704898824'
  },
  {
    'shapeName': 'Simada',
    'shapeID': '50319843B48864913891285'
  },
  {
    'shapeName': 'Siya Debirna Wayu',
    'shapeID': '50319843B60014431240861'
  },
  {
    'shapeName': 'Tach Armacho',
    'shapeID': '50319843B67412844030016'
  },
  {
    'shapeName': 'Tach Gayint',
    'shapeID': '50319843B85221111034617'
  },
  {
    'shapeName': 'Takusa',
    'shapeID': '50319843B10875054161913'
  },
  {
    'shapeName': 'Tarema Ber',
    'shapeID': '50319843B36085677456021'
  },
  {
    'shapeName': 'Tenta',
    'shapeID': '50319843B51742367489313'
  },
  {
    'shapeName': 'Thehulederie',
    'shapeID': '50319843B72427252314375'
  },
  {
    'shapeName': 'West Esite',
    'shapeID': '50319843B62959945905124'
  },
  {
    'shapeName': 'Wadla',
    'shapeID': '50319843B27486181606263'
  },
  {
    'shapeName': 'Wegde',
    'shapeID': '50319843B12095777802104'
  },
  {
    'shapeName': 'Wegera',
    'shapeID': '50319843B77229165834460'
  },
  {
    'shapeName': 'Wemberma',
    'shapeID': '50319843B1322867008327'
  },
  {
    'shapeName': 'Were Ilu',
    'shapeID': '50319843B75121160015877'
  },
  {
    'shapeName': 'West Belesa',
    'shapeID': '50319843B1212458342207'
  },
  {
    'shapeName': 'Worebabu',
    'shapeID': '50319843B77245987371775'
  },
  {
    'shapeName': 'Yilmana Densa',
    'shapeID': '50319843B63873055597632'
  },
  {
    'shapeName': 'Ziquala',
    'shapeID': '50319843B4063656221590'
  },
  {
    'shapeName': 'Tsegede',
    'shapeID': '50319843B79272383349726'
  },
  {
    'shapeName': 'Addi Arekay',
    'shapeID': '50319843B8466338820525'
  },
  {
    'shapeName': 'Tselemt',
    'shapeID': '50319843B49803313364431'
  },
  {
    'shapeName': 'Abergele',
    'shapeID': '50319843B3225970746512'
  },
  {
    'shapeName': 'Sekota',
    'shapeID': '50319843B71917251620513'
  },
  {
    'shapeName': 'Kobo',
    'shapeID': '50319843B66997857814684'
  },
  {
    'shapeName': 'Artuma Fursi',
    'shapeID': '50319843B58741658204250'
  },
  {
    'shapeName': 'Dewa Harewa',
    'shapeID': '50319843B88232319036471'
  },
  {
    'shapeName': 'Afdera',
    'shapeID': '50319843B78334315554077'
  },
  {
    'shapeName': 'Erebti',
    'shapeID': '50319843B50750807878020'
  },
  {
    'shapeName': 'Elidar',
    'shapeID': '50319843B60371596787586'
  },
  {
    'shapeName': 'Teru',
    'shapeID': '50319843B27334186268795'
  },
  {
    'shapeName': 'Dubti',
    'shapeID': '50319843B52535210723935'
  },
  {
    'shapeName': 'Awra',
    'shapeID': '50319843B39880857506630'
  },
  {
    'shapeName': 'Aysaita',
    'shapeID': '50319843B56277227631253'
  },
  {
    'shapeName': 'Afambo',
    'shapeID': '50319843B72561008771226'
  },
  {
    'shapeName': 'Gewane',
    'shapeID': '50319843B90613086004574'
  },
  {
    'shapeName': 'Bure Mudaytu',
    'shapeID': '50319843B30245915008972'
  },
  {
    'shapeName': 'Amibara',
    'shapeID': '50319843B27482936834806'
  },
  {
    'shapeName': 'Argoba Special',
    'shapeID': '50319843B47484581498305'
  },
  {
    'shapeName': 'Dulecha',
    'shapeID': '50319843B16529942858125'
  },
  {
    'shapeName': 'Awash Fentale',
    'shapeID': '50319843B52122682372880'
  },
  {
    'shapeName': 'Dalul',
    'shapeID': '50319843B76669720282723'
  },
  {
    'shapeName': 'Koneba',
    'shapeID': '50319843B90079319544090'
  },
  {
    'shapeName': 'Berahile',
    'shapeID': '50319843B68998189635987'
  },
  {
    'shapeName': 'Ab Ala',
    'shapeID': '50319843B32541457108562'
  },
  {
    'shapeName': 'Megale',
    'shapeID': '50319843B26124706637342'
  },
  {
    'shapeName': 'Yalo',
    'shapeID': '50319843B23248676893698'
  },
  {
    'shapeName': 'Gulina',
    'shapeID': '50319843B63792898684948'
  },
  {
    'shapeName': 'Ewa',
    'shapeID': '50319843B80817410202580'
  },
  {
    'shapeName': 'Chifra',
    'shapeID': '50319843B52972268681493'
  },
  {
    'shapeName': 'Mile',
    'shapeID': '50319843B53804785347293'
  },
  {
    'shapeName': 'Telalak',
    'shapeID': '50319843B81683434568938'
  },
  {
    'shapeName': 'Dalfagi',
    'shapeID': '50319843B11598870031006'
  },
  {
    'shapeName': 'Dewe',
    'shapeID': '50319843B18198692632237'
  },
  {
    'shapeName': 'Simurobi Gele\'alo',
    'shapeID': '50319843B61212201688011'
  },
  {
    'shapeName': 'Hadelela',
    'shapeID': '50319843B32781600797454'
  },
  {
    'shapeName': 'Dera',
    'shapeID': '50319843B32869776717164'
  },
  {
    'shapeName': 'Ibantu',
    'shapeID': '50319843B49356994880908'
  },
  {
    'shapeName': 'Wara Jarso',
    'shapeID': '50319843B49354689315918'
  },
  {
    'shapeName': 'Hidabu Abote',
    'shapeID': '50319843B47569419813687'
  },
  {
    'shapeName': 'Limu',
    'shapeID': '50319843B92591588692216'
  },
  {
    'shapeName': 'Guduru',
    'shapeID': '50319843B85143910918585'
  },
  {
    'shapeName': 'Degem',
    'shapeID': '50319843B43958255890156'
  },
  {
    'shapeName': 'Abay Chomen',
    'shapeID': '50319843B91412917671358'
  },
  {
    'shapeName': 'Gerar Jarso',
    'shapeID': '50319843B22904015360179'
  },
  {
    'shapeName': 'Ginde Beret',
    'shapeID': '50319843B10294359195216'
  },
  {
    'shapeName': 'Kuyu',
    'shapeID': '50319843B79894812900460'
  },
  {
    'shapeName': 'Horo',
    'shapeID': '50319843B94347606642365'
  },
  {
    'shapeName': 'Abe Dongoro',
    'shapeID': '50319843B63078856064372'
  },
  {
    'shapeName': 'Wuchale',
    'shapeID': '50319843B72352173357300'
  },
  {
    'shapeName': 'Yaya Gulele',
    'shapeID': '50319843B64914066758451'
  },
  {
    'shapeName': 'Jarso',
    'shapeID': '50319843B26750258806311'
  },
  {
    'shapeName': 'Meta Robi',
    'shapeID': '50319843B17700146727656'
  },
  {
    'shapeName': 'Begi',
    'shapeID': '50319843B79193950686838'
  },
  {
    'shapeName': 'Kombolcha',
    'shapeID': '50319843B54127729421374'
  },
  {
    'shapeName': 'Adda Berga',
    'shapeID': '50319843B15504069858787'
  },
  {
    'shapeName': 'Babo',
    'shapeID': '50319843B43095166568160'
  },
  {
    'shapeName': 'Bila Seyo',
    'shapeID': '50319843B21266272397257'
  },
  {
    'shapeName': 'Meta',
    'shapeID': '50319843B17546702599311'
  },
  {
    'shapeName': 'Haro Maya',
    'shapeID': '50319843B8225782821988'
  },
  {
    'shapeName': 'Sasiga',
    'shapeID': '50319843B65726047023049'
  },
  {
    'shapeName': 'Goro Gutu',
    'shapeID': '50319843B37307602387397'
  },
  {
    'shapeName': 'Guto Gida',
    'shapeID': '50319843B94350061463598'
  },
  {
    'shapeName': 'Gursum',
    'shapeID': '50319843B47842488393797'
  },
  {
    'shapeName': 'Kersa',
    'shapeID': '50319843B74830227558148'
  },
  {
    'shapeName': 'Jeldu',
    'shapeID': '50319843B62404021241896'
  },
  {
    'shapeName': 'Doba',
    'shapeID': '50319843B8256081654516'
  },
  {
    'shapeName': 'Mieso',
    'shapeID': '50319843B19524001914214'
  },
  {
    'shapeName': 'Deder',
    'shapeID': '50319843B42231502886922'
  },
  {
    'shapeName': 'Cheliya',
    'shapeID': '50319843B98726514598343'
  },
  {
    'shapeName': 'Gawo Kebe',
    'shapeID': '50319843B77679966567353'
  },
  {
    'shapeName': 'Babile',
    'shapeID': '50319843B28396451951'
  },
  {
    'shapeName': 'Ambo Zuria',
    'shapeID': '50319843B86802411979156'
  },
  {
    'shapeName': 'Jimma Rare',
    'shapeID': '50319843B17084472394811'
  },
  {
    'shapeName': 'Kurfa Chele',
    'shapeID': '50319843B1565553569154'
  },
  {
    'shapeName': 'Tulo',
    'shapeID': '50319843B92393872271112'
  },
  {
    'shapeName': 'Bedeno',
    'shapeID': '50319843B46291413928725'
  },
  {
    'shapeName': 'Dendi',
    'shapeID': '50319843B91832256121688'
  },
  {
    'shapeName': 'Ejere (Addis Alem)',
    'shapeID': '50319843B29879087282898'
  },
  {
    'shapeName': 'Girawa',
    'shapeID': '50319843B32998145799392'
  },
  {
    'shapeName': 'Bako Tibe',
    'shapeID': '50319843B23692988923124'
  },
  {
    'shapeName': 'Malka Balo',
    'shapeID': '50319843B49597989285525'
  },
  {
    'shapeName': 'Ginir',
    'shapeID': '50319843B90038376618662'
  },
  {
    'shapeName': 'Adaba',
    'shapeID': '50319843B94997552154219'
  },
  {
    'shapeName': 'Shashemene Zuria',
    'shapeID': '50319843B15175617507606'
  },
  {
    'shapeName': 'Kofele',
    'shapeID': '50319843B51705642375113'
  },
  {
    'shapeName': 'Gedeb Asasa',
    'shapeID': '50319843B76644063100824'
  },
  {
    'shapeName': 'Sinana',
    'shapeID': '50319843B12282788609325'
  },
  {
    'shapeName': 'Golo Oda',
    'shapeID': '50319843B74622452192338'
  },
  {
    'shapeName': 'Rayitu',
    'shapeID': '50319843B22394839917876'
  },
  {
    'shapeName': 'Fedis',
    'shapeID': '50319843B12076075779213'
  },
  {
    'shapeName': 'Gemechis',
    'shapeID': '50319843B20549058048866'
  },
  {
    'shapeName': 'Mesela',
    'shapeID': '50319843B24521076676892'
  },
  {
    'shapeName': 'Fentale',
    'shapeID': '50319843B1280763687952'
  },
  {
    'shapeName': 'Haru',
    'shapeID': '50319843B41551337881389'
  },
  {
    'shapeName': 'Anchar',
    'shapeID': '50319843B99915229022049'
  },
  {
    'shapeName': 'Yubdo',
    'shapeID': '50319843B22237587200155'
  },
  {
    'shapeName': 'Wama Hagalo',
    'shapeID': '50319843B37281190182569'
  },
  {
    'shapeName': 'Jarte Jardega',
    'shapeID': '50319843B62211553148258'
  },
  {
    'shapeName': 'Kuni',
    'shapeID': '50319843B71948753636433'
  },
  {
    'shapeName': 'Nole Kaba',
    'shapeID': '50319843B73634494906948'
  },
  {
    'shapeName': 'Ilu',
    'shapeID': '50319843B72083913024896'
  },
  {
    'shapeName': 'Tikur Enchini',
    'shapeID': '50319843B52846432434751'
  },
  {
    'shapeName': 'Ada\'a',
    'shapeID': '50319843B3829043094110'
  },
  {
    'shapeName': 'Dawo',
    'shapeID': '50319843B51633789929871'
  },
  {
    'shapeName': 'Dano',
    'shapeID': '50319843B68575098788310'
  },
  {
    'shapeName': 'Jimma Arjo',
    'shapeID': '50319843B20514336190133'
  },
  {
    'shapeName': 'Meko',
    'shapeID': '50319843B19918784136845'
  },
  {
    'shapeName': 'Habro',
    'shapeID': '50319843B44913717697007'
  },
  {
    'shapeName': 'Nono',
    'shapeID': '50319843B82349203376088'
  },
  {
    'shapeName': 'Limu Seka',
    'shapeID': '50319843B71704473224941'
  },
  {
    'shapeName': 'Merti',
    'shapeID': '50319843B31099514661901'
  },
  {
    'shapeName': 'Hawa Galan',
    'shapeID': '50319843B35442894835705'
  },
  {
    'shapeName': 'Nunu Kumba',
    'shapeID': '50319843B20026291364900'
  },
  {
    'shapeName': 'Boset',
    'shapeID': '50319843B7390192296640'
  },
  {
    'shapeName': 'Lome',
    'shapeID': '50319843B62671617997991'
  },
  {
    'shapeName': 'Boke',
    'shapeID': '50319843B86820508454623'
  },
  {
    'shapeName': 'Wenchi',
    'shapeID': '50319843B56311693206321'
  },
  {
    'shapeName': 'Tole',
    'shapeID': '50319843B81049265464187'
  },
  {
    'shapeName': 'Darimu',
    'shapeID': '50319843B22229189283502'
  },
  {
    'shapeName': 'Ameya',
    'shapeID': '50319843B69206055972162'
  },
  {
    'shapeName': 'Becho',
    'shapeID': '50319843B43764795329538'
  },
  {
    'shapeName': 'Adama',
    'shapeID': '50319843B58820455556680'
  },
  {
    'shapeName': 'Waliso',
    'shapeID': '50319843B9023011530965'
  },
  {
    'shapeName': 'Alge Sachi',
    'shapeID': '50319843B46958367314201'
  },
  {
    'shapeName': 'Aseko',
    'shapeID': '50319843B2938567297280'
  },
  {
    'shapeName': 'Gololcha Arsi',
    'shapeID': '50319843B40577795069949'
  },
  {
    'shapeName': 'Chora',
    'shapeID': '50319843B60952650115767'
  },
  {
    'shapeName': 'Jeju',
    'shapeID': '50319843B81941222016814'
  },
  {
    'shapeName': 'Seden Sodo',
    'shapeID': '50319843B56942532821695'
  },
  {
    'shapeName': 'Chora',
    'shapeID': '50319843B97580912634167'
  },
  {
    'shapeName': 'Sire',
    'shapeID': '50319843B90599735188960'
  },
  {
    'shapeName': 'Metu Zuria',
    'shapeID': '50319843B63224347439046'
  },
  {
    'shapeName': 'Yayu',
    'shapeID': '50319843B64162650444857'
  },
  {
    'shapeName': 'Dugda',
    'shapeID': '50319843B20771113025734'
  },
  {
    'shapeName': 'Chole',
    'shapeID': '50319843B25066657167656'
  },
  {
    'shapeName': 'Ziway Dugda',
    'shapeID': '50319843B64482246208254'
  },
  {
    'shapeName': 'Didu',
    'shapeID': '50319843B88192331214985'
  },
  {
    'shapeName': 'Sude',
    'shapeID': '50319843B66350491447172'
  },
  {
    'shapeName': 'Setema',
    'shapeID': '50319843B51589986946875'
  },
  {
    'shapeName': 'Hitosa',
    'shapeID': '50319843B23263571250236'
  },
  {
    'shapeName': 'Dedesa',
    'shapeID': '50319843B60269870577466'
  },
  {
    'shapeName': 'Sigmo',
    'shapeID': '50319843B43824774178194'
  },
  {
    'shapeName': 'Tiro Afeta',
    'shapeID': '50319843B47221050228030'
  },
  {
    'shapeName': 'Lege Hida',
    'shapeID': '50319843B47383109714978'
  },
  {
    'shapeName': 'Amigna',
    'shapeID': '50319843B78235441050215'
  },
  {
    'shapeName': 'Goma',
    'shapeID': '50319843B14930678582515'
  },
  {
    'shapeName': 'Adami Tulu Jido Kombolcha',
    'shapeID': '50319843B63289556303956'
  },
  {
    'shapeName': 'Tiyo',
    'shapeID': '50319843B93956095828916'
  },
  {
    'shapeName': 'Kersa',
    'shapeID': '50319843B1701869736862'
  },
  {
    'shapeName': 'Sekoru',
    'shapeID': '50319843B908644087643'
  },
  {
    'shapeName': 'Robe',
    'shapeID': '50319843B99897294433296'
  },
  {
    'shapeName': 'Gera',
    'shapeID': '50319843B20325197952911'
  },
  {
    'shapeName': 'Mena',
    'shapeID': '50319843B2665349939429'
  },
  {
    'shapeName': 'Seru',
    'shapeID': '50319843B47882216502335'
  },
  {
    'shapeName': 'Degeluna Tijo',
    'shapeID': '50319843B21991569545926'
  },
  {
    'shapeName': 'Gololcha Bale',
    'shapeID': '50319843B73042523977322'
  },
  {
    'shapeName': 'Omo Nada',
    'shapeID': '50319843B5229662794766'
  },
  {
    'shapeName': 'Munessa',
    'shapeID': '50319843B73128677639174'
  },
  {
    'shapeName': 'Shebe Sambo',
    'shapeID': '50319843B27002310781291'
  },
  {
    'shapeName': 'Seweyna',
    'shapeID': '50319843B9791389981442'
  },
  {
    'shapeName': 'Shirka',
    'shapeID': '50319843B80105633193174'
  },
  {
    'shapeName': 'Arsi Negele',
    'shapeID': '50319843B3574799360253'
  },
  {
    'shapeName': 'Dedo',
    'shapeID': '50319843B77341820335695'
  },
  {
    'shapeName': 'Limu Bilbilo',
    'shapeID': '50319843B1398542089329'
  },
  {
    'shapeName': 'Shalla',
    'shapeID': '50319843B56317892319459'
  },
  {
    'shapeName': 'Agarfa',
    'shapeID': '50319843B13366155069655'
  },
  {
    'shapeName': 'Dawe Kachen',
    'shapeID': '50319843B72108958001947'
  },
  {
    'shapeName': 'Dodola',
    'shapeID': '50319843B7384342314711'
  },
  {
    'shapeName': 'Goba',
    'shapeID': '50319843B89558929493336'
  },
  {
    'shapeName': 'Kokosa',
    'shapeID': '50319843B65247004591652'
  },
  {
    'shapeName': 'Berbere',
    'shapeID': '50319843B64956751586269'
  },
  {
    'shapeName': 'Gura Damole',
    'shapeID': '50319843B25834187367439'
  },
  {
    'shapeName': 'Nenesebo (Wereka)',
    'shapeID': '50319843B40018199978439'
  },
  {
    'shapeName': 'Mena',
    'shapeID': '50319843B21330475575706'
  },
  {
    'shapeName': 'Gelana',
    'shapeID': '50319843B75225294383853'
  },
  {
    'shapeName': 'Uraga',
    'shapeID': '50319843B52356602733721'
  },
  {
    'shapeName': 'Meda Welabu',
    'shapeID': '50319843B47582531758345'
  },
  {
    'shapeName': 'Adola',
    'shapeID': '50319843B75184808949550'
  },
  {
    'shapeName': 'Teltele',
    'shapeID': '50319843B52241691529959'
  },
  {
    'shapeName': 'Moyale',
    'shapeID': '50319843B6188902685726'
  },
  {
    'shapeName': 'Borecha',
    'shapeID': '50319843B14391650931626'
  },
  {
    'shapeName': 'Lalo Kile',
    'shapeID': '50319843B55308849027342'
  },
  {
    'shapeName': 'Jarso',
    'shapeID': '50319843B97073428491723'
  },
  {
    'shapeName': 'Jimma Horo',
    'shapeID': '50319843B9989695552995'
  },
  {
    'shapeName': 'Yama Logi Welel',
    'shapeID': '50319843B28022845428625'
  },
  {
    'shapeName': 'Dale Wabera',
    'shapeID': '50319843B43777175646012'
  },
  {
    'shapeName': 'Dale Sadi',
    'shapeID': '50319843B39492316205037'
  },
  {
    'shapeName': 'Boji Chekorsa',
    'shapeID': '50319843B19769872558897'
  },
  {
    'shapeName': 'Gaji',
    'shapeID': '50319843B26190567886891'
  },
  {
    'shapeName': 'Sayo Nole',
    'shapeID': '50319843B79369141912505'
  },
  {
    'shapeName': 'Dega',
    'shapeID': '50319843B60928877732775'
  },
  {
    'shapeName': 'Bilo Nopha',
    'shapeID': '50319843B46348590960117'
  },
  {
    'shapeName': 'Halu (Huka)',
    'shapeID': '50319843B91615051171152'
  },
  {
    'shapeName': 'Ale',
    'shapeID': '50319843B98132793389535'
  },
  {
    'shapeName': 'Hurumu',
    'shapeID': '50319843B38996999257227'
  },
  {
    'shapeName': 'Becho',
    'shapeID': '50319843B63388152582179'
  },
  {
    'shapeName': 'Gechi',
    'shapeID': '50319843B12413251563254'
  },
  {
    'shapeName': 'Badele Zuria',
    'shapeID': '50319843B42132046090044'
  },
  {
    'shapeName': 'Dorani',
    'shapeID': '50319843B75545367432653'
  },
  {
    'shapeName': 'Boneya Boshe',
    'shapeID': '50319843B91753056032036'
  },
  {
    'shapeName': 'Gobu Seyo',
    'shapeID': '50319843B74665703929489'
  },
  {
    'shapeName': 'Leka Dulecha',
    'shapeID': '50319843B13831239785039'
  },
  {
    'shapeName': 'Sibu Sire',
    'shapeID': '50319843B61255265552333'
  },
  {
    'shapeName': 'Wayu Tuka',
    'shapeID': '50319843B97645902862980'
  },
  {
    'shapeName': 'Amuru',
    'shapeID': '50319843B12250536959225'
  },
  {
    'shapeName': 'Jimma Genete',
    'shapeID': '50319843B98344065254358'
  },
  {
    'shapeName': 'Ababo',
    'shapeID': '50319843B82399309320079'
  },
  {
    'shapeName': 'Gumay',
    'shapeID': '50319843B6837976392261'
  },
  {
    'shapeName': 'Seka Chekorsa',
    'shapeID': '50319843B29177337070877'
  },
  {
    'shapeName': 'Limu Kosa',
    'shapeID': '50319843B71815402055907'
  },
  {
    'shapeName': 'Abuna G/Beret',
    'shapeID': '50319843B60482645869509'
  },
  {
    'shapeName': 'Ifata',
    'shapeID': '50319843B88383760633086'
  },
  {
    'shapeName': 'Toke Kutaye',
    'shapeID': '50319843B52833088937952'
  },
  {
    'shapeName': 'Mida Kegn',
    'shapeID': '50319843B79427840844562'
  },
  {
    'shapeName': 'Jibat',
    'shapeID': '50319843B74997950602225'
  },
  {
    'shapeName': 'Goro',
    'shapeID': '50319843B61549556038911'
  },
  {
    'shapeName': 'Kersana Malima',
    'shapeID': '50319843B6871701614928'
  },
  {
    'shapeName': 'Debre Libanos',
    'shapeID': '50319843B73573246995928'
  },
  {
    'shapeName': 'Mulo',
    'shapeID': '50319843B74772373577962'
  },
  {
    'shapeName': 'Aleltu',
    'shapeID': '50319843B58410095506852'
  },
  {
    'shapeName': 'Jida',
    'shapeID': '50319843B61331975512132'
  },
  {
    'shapeName': 'Bora',
    'shapeID': '50319843B3528243700942'
  },
  {
    'shapeName': 'Liben Chukala',
    'shapeID': '50319843B9544707689813'
  },
  {
    'shapeName': 'Dodota',
    'shapeID': '50319843B52325560801734'
  },
  {
    'shapeName': 'Lude Hitosa',
    'shapeID': '50319843B24153274174962'
  },
  {
    'shapeName': 'Tena',
    'shapeID': '50319843B6197143564651'
  },
  {
    'shapeName': 'Diksis',
    'shapeID': '50319843B33068433640857'
  },
  {
    'shapeName': 'Inkolo Wabe',
    'shapeID': '50319843B62164162382975'
  },
  {
    'shapeName': 'Guna',
    'shapeID': '50319843B96043411216260'
  },
  {
    'shapeName': 'Bele Gesgar',
    'shapeID': '50319843B77375076827374'
  },
  {
    'shapeName': 'Siraro',
    'shapeID': '50319843B80269303071732'
  },
  {
    'shapeName': 'Kore',
    'shapeID': '50319843B34689260592350'
  },
  {
    'shapeName': 'Goba Koricha',
    'shapeID': '50319843B62871627712169'
  },
  {
    'shapeName': 'Chiro Zuria',
    'shapeID': '50319843B74207669874916'
  },
  {
    'shapeName': 'Midega Tola',
    'shapeID': '50319843B5142122926217'
  },
  {
    'shapeName': 'Meyu',
    'shapeID': '50319843B71454988155410'
  },
  {
    'shapeName': 'Chinaksen',
    'shapeID': '50319843B55329706724277'
  },
  {
    'shapeName': 'Gasera',
    'shapeID': '50319843B51917027892122'
  },
  {
    'shapeName': 'Dinsho',
    'shapeID': '50319843B79338232621018'
  },
  {
    'shapeName': 'Harena Buluk',
    'shapeID': '50319843B75480736241697'
  },
  {
    'shapeName': 'Goro',
    'shapeID': '50319843B69926404084914'
  },
  {
    'shapeName': 'Afele Kola (Dima)',
    'shapeID': '50319843B57503615238442'
  },
  {
    'shapeName': 'Kercha',
    'shapeID': '50319843B40601502549075'
  },
  {
    'shapeName': 'Girja (Harenfema)',
    'shapeID': '50319843B10741708311702'
  },
  {
    'shapeName': 'Wadera',
    'shapeID': '50319843B69908014789449'
  },
  {
    'shapeName': 'Abaya',
    'shapeID': '50319843B73059008862575'
  },
  {
    'shapeName': 'Bule Hora',
    'shapeID': '50319843B8835509340837'
  },
  {
    'shapeName': 'Yabelo',
    'shapeID': '50319843B22171987497601'
  },
  {
    'shapeName': 'Sodo Daci',
    'shapeID': '50319843B33075108019166'
  },
  {
    'shapeName': 'Kondaltiti',
    'shapeID': '50319843B79540682027357'
  },
  {
    'shapeName': 'Dugda Dawa',
    'shapeID': '50319843B83203580246835'
  },
  {
    'shapeName': 'Melka Soda',
    'shapeID': '50319843B1303854675095'
  },
  {
    'shapeName': 'Dillo',
    'shapeID': '50319843B49305994837992'
  },
  {
    'shapeName': 'Dire',
    'shapeID': '50319843B89633702810677'
  },
  {
    'shapeName': 'Miyo',
    'shapeID': '50319843B59847550020843'
  },
  {
    'shapeName': 'Dehas',
    'shapeID': '50319843B43153089923118'
  },
  {
    'shapeName': 'Arero',
    'shapeID': '50319843B71275043871336'
  },
  {
    'shapeName': 'Gidami',
    'shapeID': '50319843B5429517704908'
  },
  {
    'shapeName': 'Anfilo',
    'shapeID': '50319843B87130152017910'
  },
  {
    'shapeName': 'Bure',
    'shapeID': '50319843B30796244240761'
  },
  {
    'shapeName': 'Sayo',
    'shapeID': '50319843B59638509480608'
  },
  {
    'shapeName': 'Sale Nono',
    'shapeID': '50319843B90455690381836'
  },
  {
    'shapeName': 'Gudetu Kondole',
    'shapeID': '50319843B16967478839768'
  },
  {
    'shapeName': 'Mana Sibu',
    'shapeID': '50319843B24777362817820'
  },
  {
    'shapeName': 'Kiltu Kara',
    'shapeID': '50319843B8682291288709'
  },
  {
    'shapeName': 'Nejo',
    'shapeID': '50319843B61166105479841'
  },
  {
    'shapeName': 'Boji Dirmeji',
    'shapeID': '50319843B27281788387380'
  },
  {
    'shapeName': 'Lalo Asabi',
    'shapeID': '50319843B7874918453404'
  },
  {
    'shapeName': 'Gimbi',
    'shapeID': '50319843B65561720440907'
  },
  {
    'shapeName': 'Chwaka',
    'shapeID': '50319843B30530008819203'
  },
  {
    'shapeName': 'Dabo Hana',
    'shapeID': '50319843B35423323406856'
  },
  {
    'shapeName': 'Diga',
    'shapeID': '50319843B91418489525721'
  },
  {
    'shapeName': 'Haro Limu',
    'shapeID': '50319843B9952897260908'
  },
  {
    'shapeName': 'Abichuna Gne\'a',
    'shapeID': '50319843B97146734237899'
  },
  {
    'shapeName': 'Kembibit',
    'shapeID': '50319843B48541796113830'
  },
  {
    'shapeName': 'Gimbichu',
    'shapeID': '50319843B461830459458'
  },
  {
    'shapeName': 'Walmara',
    'shapeID': '50319843B86276017000960'
  },
  {
    'shapeName': 'Akaki',
    'shapeID': '50319843B9640206479564'
  },
  {
    'shapeName': 'Bereh',
    'shapeID': '50319843B89683961155448'
  },
  {
    'shapeName': 'Sululta',
    'shapeID': '50319843B28566166526861'
  },
  {
    'shapeName': 'Alem Gena',
    'shapeID': '50319843B79951431027403'
  },
  {
    'shapeName': 'Basona Worena',
    'shapeID': '50319843B50435576329612'
  },
  {
    'shapeName': 'Ensaro',
    'shapeID': '50319843B21060277399443'
  },
  {
    'shapeName': 'Akaki - Kalit',
    'shapeID': '50319843B92658016938888'
  },
  {
    'shapeName': 'Kolfe - Keran',
    'shapeID': '50319843B54661776069152'
  },
  {
    'shapeName': 'Hawi Gudina\n',
    'shapeID': '50319843B87365280520857'
  },
  {
    'shapeName': 'Daro Lebu',
    'shapeID': '50319843B76526538327477'
  },
  {
    'shapeName': 'Hargele',
    'shapeID': '50319843B35831075283768'
  },
  {
    'shapeName': 'Bidu',
    'shapeID': '50319843B62307777045684'
  },
  {
    'shapeName': 'Kurri',
    'shapeID': '50319843B34325794745738'
  },
  {
    'shapeName': 'Adaa\'r',
    'shapeID': '50319843B66676599488407'
  },
  {
    'shapeName': 'Yeki',
    'shapeID': '50319843B25689384620733'
  },
  {
    'shapeName': 'Menjiwo',
    'shapeID': '50319843B98049995429821'
  },
  {
    'shapeName': 'Kacha Bira',
    'shapeID': '50319843B92874070540990'
  },
  {
    'shapeName': 'Tembaro',
    'shapeID': '50319843B81878624802420'
  },
  {
    'shapeName': 'Decha',
    'shapeID': '50319843B63900090067273'
  },
  {
    'shapeName': 'Menit Shasha',
    'shapeID': '50319843B25864552055462'
  },
  {
    'shapeName': 'Ela (Konta) SP Woreda',
    'shapeID': '50319843B87272712508300'
  },
  {
    'shapeName': 'Cheta',
    'shapeID': '50319843B11626939712279'
  },
  {
    'shapeName': 'Loma Bosa',
    'shapeID': '50319843B95284659079339'
  },
  {
    'shapeName': 'Boreda',
    'shapeID': '50319843B31987793756049'
  },
  {
    'shapeName': 'Sodo',
    'shapeID': '50319843B13394907086884'
  },
  {
    'shapeName': 'Abeshege',
    'shapeID': '50319843B43036908648547'
  },
  {
    'shapeName': 'Kokir Gedbano',
    'shapeID': '50319843B66041243751687'
  },
  {
    'shapeName': 'Meskan',
    'shapeID': '50319843B4477930446360'
  },
  {
    'shapeName': 'Cheha',
    'shapeID': '50319843B77038475643348'
  },
  {
    'shapeName': 'South Ari (Bako Gazer)',
    'shapeID': '50319843B18502898382194'
  },
  {
    'shapeName': 'Enemorina Eaner',
    'shapeID': '50319843B23731884944842'
  },
  {
    'shapeName': 'Alicho Woriro',
    'shapeID': '50319843B5209652744102'
  },
  {
    'shapeName': 'Selti',
    'shapeID': '50319843B79843554910590'
  },
  {
    'shapeName': 'Yem SP Woreda',
    'shapeID': '50319843B15936830244990'
  },
  {
    'shapeName': 'Gibe',
    'shapeID': '50319843B70411399875669'
  },
  {
    'shapeName': 'Lanfero',
    'shapeID': '50319843B15561983053130'
  },
  {
    'shapeName': 'Gesha (Deka)',
    'shapeID': '50319843B57973415681579'
  },
  {
    'shapeName': 'Wilbareg',
    'shapeID': '50319843B18654170283745'
  },
  {
    'shapeName': 'Soro',
    'shapeID': '50319843B87885766178330'
  },
  {
    'shapeName': 'Masha',
    'shapeID': '50319843B26938033645640'
  },
  {
    'shapeName': 'Gimbo',
    'shapeID': '50319843B24841231431782'
  },
  {
    'shapeName': 'Alaba SP Woreda',
    'shapeID': '50319843B87348110485459'
  },
  {
    'shapeName': 'Anigacha',
    'shapeID': '50319843B67936818914140'
  },
  {
    'shapeName': 'Chena',
    'shapeID': '50319843B53058324707927'
  },
  {
    'shapeName': 'Boloso sore',
    'shapeID': '50319843B36952570538345'
  },
  {
    'shapeName': 'Mareka',
    'shapeID': '50319843B74196190345489'
  },
  {
    'shapeName': 'Wondo-Genet',
    'shapeID': '50319843B97428122538189'
  },
  {
    'shapeName': 'Damot Gale',
    'shapeID': '50319843B81544557719987'
  },
  {
    'shapeName': 'Esira',
    'shapeID': '50319843B70240676792322'
  },
  {
    'shapeName': 'Sodo Zuria',
    'shapeID': '50319843B86284461716694'
  },
  {
    'shapeName': 'Loka Abaya',
    'shapeID': '50319843B64393637944143'
  },
  {
    'shapeName': 'Arbe Gonna',
    'shapeID': '50319843B64031810692906'
  },
  {
    'shapeName': 'Ofa',
    'shapeID': '50319843B67227442360279'
  },
  {
    'shapeName': 'Hulla',
    'shapeID': '50319843B71263206981525'
  },
  {
    'shapeName': 'Chuko',
    'shapeID': '50319843B45499659265962'
  },
  {
    'shapeName': 'Melekoza',
    'shapeID': '50319843B23486963859874'
  },
  {
    'shapeName': 'Kucha',
    'shapeID': '50319843B87752805379492'
  },
  {
    'shapeName': 'Chire',
    'shapeID': '50319843B78037632259273'
  },
  {
    'shapeName': 'Denibu Gofa',
    'shapeID': '50319843B85094308191059'
  },
  {
    'shapeName': 'Aroresa',
    'shapeID': '50319843B79577233938150'
  },
  {
    'shapeName': 'Dara',
    'shapeID': '50319843B89924142287313'
  },
  {
    'shapeName': 'Surma',
    'shapeID': '50319843B37916715631022'
  },
  {
    'shapeName': 'Selamgo',
    'shapeID': '50319843B88052652597323'
  },
  {
    'shapeName': 'Maji',
    'shapeID': '50319843B66834241233663'
  },
  {
    'shapeName': 'Chencha',
    'shapeID': '50319843B79384057544721'
  },
  {
    'shapeName': 'Dita',
    'shapeID': '50319843B25612063989082'
  },
  {
    'shapeName': 'Basketo SP Woreda',
    'shapeID': '50319843B71119209843183'
  },
  {
    'shapeName': 'Daramalo',
    'shapeID': '50319843B45265872307986'
  },
  {
    'shapeName': 'Bule',
    'shapeID': '50319843B90250243790946'
  },
  {
    'shapeName': 'Yirgachefe',
    'shapeID': '50319843B54883734397057'
  },
  {
    'shapeName': 'Arba Minch Zuria',
    'shapeID': '50319843B26190971341501'
  },
  {
    'shapeName': 'Shay Bench',
    'shapeID': '50319843B93402858337175'
  },
  {
    'shapeName': 'Amaro',
    'shapeID': '50319843B4507012952434'
  },
  {
    'shapeName': 'Burji',
    'shapeID': '50319843B22950218904110'
  },
  {
    'shapeName': 'Konso',
    'shapeID': '50319843B89255609579775'
  },
  {
    'shapeName': 'Gnangatom',
    'shapeID': '50319843B52274911012673'
  },
  {
    'shapeName': 'Zala',
    'shapeID': '50319843B45855989545937'
  },
  {
    'shapeName': 'Ezha',
    'shapeID': '50319843B64601819878015'
  },
  {
    'shapeName': 'Damot Sore',
    'shapeID': '50319843B27495851726894'
  },
  {
    'shapeName': 'Boloso Bombe',
    'shapeID': '50319843B35753913266883'
  },
  {
    'shapeName': 'Kindo Koysha',
    'shapeID': '50319843B13478611348226'
  },
  {
    'shapeName': 'Kindo Dida',
    'shapeID': '50319843B48727263415072'
  },
  {
    'shapeName': 'Damot Pulasa',
    'shapeID': '50319843B57042606944236'
  },
  {
    'shapeName': 'Hawassa Zuria',
    'shapeID': '50319843B44068877615393'
  },
  {
    'shapeName': 'Hawasa Town',
    'shapeID': '50319843B56177149482886'
  },
  {
    'shapeName': 'Malga',
    'shapeID': '50319843B15030610092424'
  },
  {
    'shapeName': 'Shebe Dino',
    'shapeID': '50319843B62208028299074'
  },
  {
    'shapeName': 'Gorche',
    'shapeID': '50319843B7325909933140'
  },
  {
    'shapeName': 'Dale',
    'shapeID': '50319843B64326968323870'
  },
  {
    'shapeName': 'Wonosho',
    'shapeID': '50319843B28137700885534'
  },
  {
    'shapeName': 'Humbo',
    'shapeID': '50319843B40448405517433'
  },
  {
    'shapeName': 'Aleta Wendo',
    'shapeID': '50319843B44621022575899'
  },
  {
    'shapeName': 'Bona Zuria',
    'shapeID': '50319843B86327110669306'
  },
  {
    'shapeName': 'Bursa',
    'shapeID': '50319843B8155801964294'
  },
  {
    'shapeName': 'Bensa',
    'shapeID': '50319843B63416454103019'
  },
  {
    'shapeName': 'Mareko',
    'shapeID': '50319843B3346650218624'
  },
  {
    'shapeName': 'Misha',
    'shapeID': '50319843B7930855549277'
  },
  {
    'shapeName': 'Shashogo',
    'shapeID': '50319843B649241020102'
  },
  {
    'shapeName': 'Mirab Abaya',
    'shapeID': '50319843B27237609742580'
  },
  {
    'shapeName': 'Ubadebretsehay',
    'shapeID': '50319843B42933108044112'
  },
  {
    'shapeName': 'Bena Tsemay',
    'shapeID': '50319843B31680685948351'
  },
  {
    'shapeName': 'Kochere',
    'shapeID': '50319843B32155663024446'
  },
  {
    'shapeName': 'Kochere Gedeb',
    'shapeID': '50319843B69831072320685'
  },
  {
    'shapeName': 'Wenago',
    'shapeID': '50319843B11269119613534'
  },
  {
    'shapeName': 'Dila Zuria',
    'shapeID': '50319843B85907008782234'
  },
  {
    'shapeName': 'Boricha',
    'shapeID': '50319843B33323965190962'
  },
  {
    'shapeName': 'Diguna Fango',
    'shapeID': '50319843B82460286826357'
  },
  {
    'shapeName': 'Damot Weydie',
    'shapeID': '50319843B55053343059646'
  },
  {
    'shapeName': 'Misrak Badawacho',
    'shapeID': '50319843B5397639262973'
  },
  {
    'shapeName': 'Mierab Badawacho',
    'shapeID': '50319843B12108506461056'
  },
  {
    'shapeName': 'Kebena',
    'shapeID': '50319843B77390913882053'
  },
  {
    'shapeName': 'Muhur Na Aklil',
    'shapeID': '50319843B8609278793647'
  },
  {
    'shapeName': 'Hamer',
    'shapeID': '50319843B99238285036104'
  },
  {
    'shapeName': 'Dasenech (Kuraz)',
    'shapeID': '50319843B25468573527689'
  },
  {
    'shapeName': 'Bero',
    'shapeID': '50319843B80117821430678'
  },
  {
    'shapeName': 'Gurafereda',
    'shapeID': '50319843B50755848230201'
  },
  {
    'shapeName': 'Sheka',
    'shapeID': '50319843B28182196617967'
  },
  {
    'shapeName': 'Debub Bench',
    'shapeID': '50319843B44161236533817'
  },
  {
    'shapeName': 'Semen Bench',
    'shapeID': '50319843B81826602470660'
  },
  {
    'shapeName': 'Menit Goldiye',
    'shapeID': '50319843B91915746062303'
  },
  {
    'shapeName': 'Gelila',
    'shapeID': '50319843B68714651767137'
  },
  {
    'shapeName': 'Male',
    'shapeID': '50319843B41214223278516'
  },
  {
    'shapeName': 'Ayida',
    'shapeID': '50319843B43502216927738'
  },
  {
    'shapeName': 'Geze Gofa',
    'shapeID': '50319843B81621252298562'
  },
  {
    'shapeName': 'Tocha',
    'shapeID': '50319843B59579471180180'
  },
  {
    'shapeName': 'Gena Bosa',
    'shapeID': '50319843B67276005627453'
  },
  {
    'shapeName': 'Tulo',
    'shapeID': '50319843B49976176123210'
  },
  {
    'shapeName': 'Sayilem',
    'shapeID': '50319843B3456860267438'
  },
  {
    'shapeName': 'Bita (Big)',
    'shapeID': '50319843B32844591380482'
  },
  {
    'shapeName': 'Getawa',
    'shapeID': '50319843B79250748611969'
  },
  {
    'shapeName': 'Anderacha',
    'shapeID': '50319843B70949879390364'
  },
  {
    'shapeName': 'Hadero Tubito',
    'shapeID': '50319843B39213341575744'
  },
  {
    'shapeName': 'Dune',
    'shapeID': '50319843B43283552449369'
  },
  {
    'shapeName': 'Gembora',
    'shapeID': '50319843B19506056236774'
  },
  {
    'shapeName': 'Misrak Azenet Berbere',
    'shapeID': '50319843B71762375339109'
  },
  {
    'shapeName': 'Endiguagn',
    'shapeID': '50319843B60626574680576'
  },
  {
    'shapeName': 'Limu',
    'shapeID': '50319843B76409146977537'
  },
  {
    'shapeName': 'Geta',
    'shapeID': '50319843B4642249737683'
  },
  {
    'shapeName': 'Analemmo',
    'shapeID': '50319843B90275766206229'
  },
  {
    'shapeName': 'Mierab Azenet Berbere',
    'shapeID': '50319843B11738692123126'
  },
  {
    'shapeName': 'Sankura',
    'shapeID': '50319843B67431359627333'
  },
  {
    'shapeName': 'Doya Gena',
    'shapeID': '50319843B21242309205946'
  },
  {
    'shapeName': 'Daniboya',
    'shapeID': '50319843B62655799881765'
  },
  {
    'shapeName': 'Kediada Gambela',
    'shapeID': '50319843B29541015498387'
  },
  {
    'shapeName': 'Dalocha',
    'shapeID': '50319843B73909066952907'
  },
  {
    'shapeName': 'Gumer',
    'shapeID': '50319843B12060962802264'
  },
  {
    'shapeName': 'Alle',
    'shapeID': '50319843B88271951022361'
  },
  {
    'shapeName': 'Derashe',
    'shapeID': '50319843B19378842133697'
  },
  {
    'shapeName': 'Kemba',
    'shapeID': '50319843B21567779970845'
  },
  {
    'shapeName': 'Bonke',
    'shapeID': '50319843B73427209021464'
  },
  {
    'shapeName': 'Liben',
    'shapeID': '50319843B5399116999248'
  },
  {
    'shapeName': 'Goro Dola',
    'shapeID': '50319843B49299292867953'
  },
  {
    'shapeName': 'Saba Boru',
    'shapeID': '50319843B95544222450356'
  },
  {
    'shapeName': 'Odo Shakiso',
    'shapeID': '50319843B92954306921623'
  },
  {
    'shapeName': 'Hambela Wamena',
    'shapeID': '50319843B98737042675514'
  },
  {
    'shapeName': 'Ana Sora',
    'shapeID': '50319843B49132509614118'
  },
  {
    'shapeName': 'Bore',
    'shapeID': '50319843B89358124578831'
  },
  {
    'shapeName': 'Homa',
    'shapeID': '50319843B42377022557528'
  },
  {
    'shapeName': 'Gida Ayana',
    'shapeID': '50319843B87646852212971'
  },
  {
    'shapeName': 'Kiremu',
    'shapeID': '50319843B80319615165973'
  },
  {
    'shapeName': 'Ayira',
    'shapeID': '50319843B63128185527276'
  },
  {
    'shapeName': 'Guliso',
    'shapeID': '50319843B59683644844432'
  }
];

  final firestore = FirebaseFirestore.instance;
  final regionsCollection = firestore.collection('regions');

  for (final region in regionsData) {
    await regionsCollection.doc(region['shapeID']).set({
      'shapeName': region['shapeName'],
    });
  }

  print('Regions imported successfully!');
}