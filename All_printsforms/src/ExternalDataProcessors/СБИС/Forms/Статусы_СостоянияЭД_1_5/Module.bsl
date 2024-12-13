//Форма исключительно для УФ

&НаСервереБезКонтекста
Процедура ЗаписатьИзмененияПоДокументам1С(МассивДокументов, Ини, КаталогНастроек) Экспорт
	// дублирует статусы по идентификаторам пакетов при получении списка изменений
	Для Каждого СоставПакета Из МассивДокументов Цикл
		Если СоставПакета.Свойство("Документы1С") Тогда  
			Для Каждого Строка Из СоставПакета.Документы1С Цикл
				ДублироватьСостояние(СоставПакета, Строка.значение);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаписатьПараметрыДокументовСБИС(ДанныеПоСтатусам,Ини,КаталогНастроек) Экспорт
	// добавляет свойства для документа 1С (при сопоставлении и загрузке документов)	
	Для Каждого Элемент Из ДанныеПоСтатусам Цикл
		СоставПакета=новый структура("Состояние",новый структура());
		СоставПакета.Состояние.вставить("Название",Элемент.СтруктураСвойств.ДокументСБИС_Статус);
		СоставПакета.вставить("Идентификатор", 	Элемент.СтруктураСвойств.ДокументСБИС_Ид);
		ДублироватьСостояние(СоставПакета, Элемент.Документ1С);
	КонецЦикла;
КонецФункции

&НаСервереБезКонтекста
функция ДублироватьСостояние(СоставПакета, ДокСсылка, XMLДокумента=неопределено, СтруктураФайла=неопределено) экспорт
	если Метаданные.РегистрыСведений.Найти("СостоянияЭД")<>Неопределено И Метаданные.справочники.Найти("СоглашенияОбИспользованииЭД")<>Неопределено тогда
		СтатусЭД= СоставПакета.Состояние.Название;
		СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.НеСформирован;
		соглашение=неопределено;
		
		НастройкиЭД =ОпределитьНастройкиОбменаЭДПоИсточнику(ДокСсылка, ложь);
		если НастройкиЭД= ложь тогда
			возврат ложь;
		Конецесли;	
//ВерсияРегламентаЭДО	2.0	ПеречислениеСсылка.ВерсииРегламентаОбмена1С
//ВерсияФормата	"ФНС 5.01 (с 2016г.)"	Строка
//ВерсияФорматаПакета	Версия 3.0	ПеречислениеСсылка.ВерсииФорматаПакетаЭД
//ВидЭД	Товарная накладная	ПеречислениеСсылка.ВидыЭД
//ЗапомнитьПарольКСертификату	Ложь	Булево
//ЗапомнитьПарольКСертификатуОрганизацииПолучателя	Ложь	Булево
//ИдентификаторКонтрагента	"6000000001_600101001"	Строка
//ИдентификаторОрганизации	"6000000114_600101001"	Строка
//КаталогВходящихДокументов,КаталогВходящихДокументовFTP,КаталогИсходящихДокументов,КаталогИсходящихДокументовFTP	""	Строка
//Контрагент	ООО "Поставщик"	СправочникСсылка.Контрагенты
//НаправлениеЭД	Исходящий	ПеречислениеСсылка.НаправленияЭД
//НастройкаЭДОДействует	Истина	Булево
//ОбщийРесурсВходящихДокументов	Системная учетная запись	СправочникСсылка.УчетныеЗаписиЭлектроннойПочты
//ОжидатьКвитанциюОДоставке	Истина	Булево
//Организация	Покупатель ООО	СправочникСсылка.Организации
//ПарольОрганизацииПолучателяПолучен	Ложь	Булево
//ПарольПолучен	Ложь	Булево
//ПарольПользователя		Null
//ПарольПользователяОрганизацииПолучателя		Null
//Подписывать	Ложь	Булево
//Приоритет	0	Число
//ПрофильНастроекЭДО	Покупатель ООО, Через электронную почту	СправочникСсылка.ПрофилиНастроекЭДО
//РесурсВходящихДокументов		Неопределено
//РесурсИсходящихДокументов	""	Строка
//СертификатДоступен	Ложь	Булево
//СертификатКонтрагентаДляШифрования	ХранилищеЗначения	ХранилищеЗначения
//СертификатОрганизацииДляПодписи,СертификатОрганизацииДляПодтверждения,СертификатОрганизацииДляРасшифровки,СертификатОрганизацииПолучателяДляПодписи		СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования
//СоглашениеЭД	ООО "Поставщик"	СправочникСсылка.СоглашенияОбИспользованииЭД
//СпособОбменаЭД	Через электронную почту	ПеречислениеСсылка.СпособыОбменаЭД
//ТребуетсяИзвещение	Истина	Булево
//ТребуетсяПодтверждение	Ложь	Булево
//ЭлектроннаяПочтаКонтрагента	"sdf@asf.ru"	Строка
		если не значениеЗаполнено(НастройкиЭД) тогда
			соглашение=СоздатьНастройкиЭДО(ДокСсылка);
			если соглашение <> неопределено тогда
				НастройкиЭД= ОпределитьНастройкиОбменаЭДПоИсточнику(ДокСсылка); 
			конецесли;
		иначе
			Соглашение=НастройкиЭД.СоглашениеЭД;
			попытка
				Если Соглашение.СостояниеСоглашения = Перечисления.СостоянияСоглашенийЭД.ПроверкаТехническойСовместимости 
						И СоставПакета.свойство("Событие") Тогда // подтверждение технической совместимости
					ОбъектСоглашение= Соглашение.ПолучитьОбъект();
					ОбъектСоглашение.СостояниеСоглашения=Перечисления.СостоянияСоглашенийЭД.Действует;
					ОбъектСоглашение.Записать();
				конецесли;
			исключение
			конецпопытки;
		конецесли;
		если значениеЗаполнено(НастройкиЭД) тогда
			НаборЗаписей = РегистрыСведений.СостоянияЭД.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.СсылкаНаОбъект.Установить(ДокСсылка);
			НаборЗаписей.Прочитать();
			если НаборЗаписей.Количество()>0 тогда
				НоваяЗаписьНабора = НаборЗаписей.Получить(0);
			иначе
				НоваяЗаписьНабора = НаборЗаписей.Добавить();
				НоваяЗаписьНабора.СсылкаНаОбъект=ДокСсылка;
			конецесли;
			попытка
				Если Найти(нрег(СтатусЭД), "выгружен")=1 или Найти(нрег(СтатусЭД), "загружен на сервер")=1 или Найти(нрег(СтатусЭД), "документ редактируется")=1 или Найти(нрег(СтатусЭД), "есть документ")=1 Тогда     // Выгружен или загружен на сервер
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОжидаетсяПодтверждение;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					статусФайла=перечисления.СтатусыЭД.ПереданОператору;
				ИначеЕсли Найти(нрег(СтатусЭД), "отослано приглашение")=1 Тогда      // Отправлено приглашение
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОжидаетсяОтправкаПолучателю;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ПригласитьКОбмену;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					статусФайла=перечисления.СтатусыЭД.ОтправленоИзвещение;
				ИначеЕсли Найти(нрег(СтатусЭД), "отправлен")=1 Тогда     // Отправлен
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОжидаетсяИзвещениеОПолучении;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					статусФайла=перечисления.СтатусыЭД.Отправлен;
				ИначеЕсли Найти(нрег(СтатусЭД), "ошибка")>0 или Найти(нрег(СтатусЭД), "проблемы при доставке")>0 Тогда     // Ошибки при отправке или при доставке
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОшибкаПередачи;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					статусФайла=перечисления.СтатусыЭД.ОшибкаПередачи;
				ИначеЕсли Найти(нрег(СтатусЭД),"на утверждении")=1 или Найти(нрег(СтатусЭД),"доставлен")=1 Тогда                        // Доставлен
					ДокСФ=ложь;
					Попытка
						если ТипЗнч(ДокСсылка) = Тип("ДокументСсылка.СчетФактураВыданный") тогда
							ДокСФ=истина;
						конецесли;
					Исключение
					КонецПопытки;	
					Попытка
						если ТипЗнч(ДокСсылка) = Тип("ДокументСсылка.СчетФактураПолученный") тогда
							ДокСФ=истина;
						конецесли;
					Исключение
					КонецПопытки;	
					Попытка
						если ТипЗнч(ДокСсылка) = Тип("ДокументСсылка.СчетФактура") тогда
							ДокСФ=истина;
						конецесли;
					Исключение
					КонецПопытки;	
					Если ДокСФ Тогда
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОбменЗавершен;
						НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ВсеВыполнено;
						НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ВсеВыполнено;
					иначе
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.НаУтверждении;
						НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
						НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					конецесли;
					статусФайла=перечисления.СтатусыЭД.Доставлен;
				ИначеЕсли Найти(нрег(СтатусЭД), "выполнение завершено с проблемами")=1 Тогда                        // Отклонен
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.Отклонен;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.Отклонен;
					статусФайла=перечисления.СтатусыЭД.Отклонен;
				ИначеЕсли Найти(нрег(СтатусЭД), "выполнение завершено успешно")=1 Тогда                        // Утвержден
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ОбменЗавершен;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ВсеВыполнено;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ВсеВыполнено;
					статусФайла=перечисления.СтатусыЭД.Утвержден;
				ИначеЕсли Найти(нрег(СтатусЭД), "удален")=1 Тогда                        // Удален контрагентом
					если метаданные.перечисления.СостоянияВерсийЭД.ЗначенияПеречисления.Найти("Аннулирован") <> неопределено тогда
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.Аннулирован;
					иначе
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ЗакрытПринудительно;
					конецесли;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					если метаданные.перечисления.СтатусыЭД.ЗначенияПеречисления.Найти("Аннулирован") <> неопределено тогда
						статусФайла=перечисления.СтатусыЭД.Аннулирован;
					иначе
						статусФайла=перечисления.СтатусыЭД.Приостановлен;
					конецесли;
				ИначеЕсли Найти(нрег(СтатусЭД), "отозван мной")=1 Тогда                        // Удален мной
					если метаданные.перечисления.СостоянияВерсийЭД.ЗначенияПеречисления.Найти("Аннулирован") <> неопределено тогда
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.Аннулирован;
					иначе
						СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ЗакрытПринудительно;
					конецесли;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.Отклонен;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
					если метаданные.перечисления.СтатусыЭД.ЗначенияПеречисления.Найти("Аннулирован") <> неопределено тогда
						статусФайла=перечисления.СтатусыЭД.Аннулирован;
					иначе
						статусФайла=перечисления.СтатусыЭД.Приостановлен;
					конецесли;
				Иначе
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.НеСформирован;
					НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
					статусФайла=перечисления.СтатусыЭД.НеСформирован;
				КонецЕсли;
			исключение // Вероятно Какое- то из перечислений оказалось не определено
				если метаданные.перечисления.СостоянияВерсийЭД.ЗначенияПеречисления.Найти("ТребуютсяДействия") <> неопределено тогда
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ТребуютсяДействия;
				иначе
					СостояниеВерсииЭД = перечисления.СостоянияВерсийЭД.ТребуетсяУточнитьДокумент;
				конецесли;
				НоваяЗаписьНабора.ДействияСНашейСтороны = перечисления.СводныеСостоянияЭД.ТребуютсяДействия;
				НоваяЗаписьНабора.ДействияСоСтороныДругогоУчастника = перечисления.СводныеСостоянияЭД.ДействийНеТребуется;
				статусФайла=перечисления.СтатусыЭД.ОшибкаПередачи;
				Сообщить(ОписаниеОшибки());
			конецпопытки;
			НоваяЗаписьНабора.СостояниеВерсииЭД = СостояниеВерсииЭД;
			
			если метаданные.Документы.Найти("ЭлектронныйДокументИсходящий")<> неопределено И 
					метаданные.Документы.Найти("ЭлектронныйДокументВходящий")<> неопределено тогда // новые конфигурации 
				Если СоставПакета.свойство("направление") И СоставПакета.направление = "Входящий" Тогда
					ДокументНаправление = "ЭлектронныйДокументВходящий";
				Иначе	//СоставПакета.направление = "Исходящий" 
					ДокументНаправление = "ЭлектронныйДокументИсходящий";
				КонецЕсли;
				запрос=новый запрос("ВЫБРАТЬ
				                    |	ЭД.Ссылка КАК Ссылка
				                    |ИЗ
				                    |	Документ."+ДокументНаправление+" КАК ЭД
				                    |ГДЕ
				                    |	ЭД.ВидЭД = &ВидЭД
									|	И ЭД.ДокументыОснования.ДокументОснование = &ДокументОснование");
				запрос.Параметры.Вставить("ВидЭД", НастройкиЭД.ВидЭД);
				запрос.Параметры.Вставить("ДокументОснование", ДокСсылка);
				результат=запрос.Выполнить().Выбрать();
				если результат.Следующий() тогда
					ЭлектронныйДокумент =  результат.ссылка.ПолучитьОбъект();
				иначе	//	ОбменСКонтрагентамиСлужебный.СоздатьЭлектронныйДокумент(СтруктураЭД);
					ЭлектронныйДокумент = Документы[ДокументНаправление].СоздатьДокумент();
					НоваяСтрока = ЭлектронныйДокумент.ДокументыОснования.Добавить();
					НоваяСтрока.ДокументОснование = ДокСсылка;
					ЭлектронныйДокумент.ВерсияРегламентаЭДО = НастройкиЭД.ВерсияРегламентаЭДО;
					ЭлектронныйДокумент.ВидЭД = НастройкиЭД.ВидЭД; //- вид электронного документа.
					ЭлектронныйДокумент.ДатаДокументаОтправителя= ?(СоставПакета.свойство("Дата"),СоставПакета.Дата,ДокСсылка.Дата); //- дата электронного документа в информационной базе отправителя.
					ЭлектронныйДокумент.НомерДокументаОтправителя = ?(СоставПакета.свойство("Номер"),СоставПакета.Номер,ДокСсылка.Номер); // номер электронного документа в информационной базе отправителя.
					ЭлектронныйДокумент.Дата= ЭлектронныйДокумент.ДатаДокументаОтправителя;
					//ЭлектронныйДокумент.Номер= ЭлектронныйДокумент.НомерДокументаОтправителя;
					ЭлектронныйДокумент.УникальныйИД	= СоставПакета.Идентификатор;
					ЭлектронныйДокумент.Комментарий= ?(СоставПакета.свойство("Название"),СоставПакета.Название,"");
					ЭлектронныйДокумент.Организация= НастройкиЭД.Организация;
					ЭлектронныйДокумент.Контрагент= НастройкиЭД.Контрагент;
					ЭлектронныйДокумент.НастройкаЭДО = соглашение;
					ЭлектронныйДокумент.ПрофильНастроекЭДО = соглашение.ПрофильНастроекЭДО;    //     - СправочникСсылка.ПрофилиНастроекЭДО - ссылка на профиль настроек ЭДО.
					ЭлектронныйДокумент.ТребуетсяИзвещение	= НастройкиЭД.ТребуетсяИзвещение;
					ЭлектронныйДокумент.ТребуетсяПодтверждение= НастройкиЭД.ТребуетсяПодтверждение;
					Попытка
						Ответственный =вычислить("ОбменСКонтрагентамиПереопределяемый.ПолучитьОтветственногоПоЭД(НастройкиЭД.Контрагент,соглашение);");
					Исключение
						Ответственный ="";
					КонецПопытки;	
					Если Не ЗначениеЗаполнено(Ответственный) Тогда 
						//Ответственный = Пользователи.АвторизованныйПользователь();
						//Ответственный = УправлениеПользователями.ПолучитьЗначениеПоУмолчанию(глТекущийПользователь, "ОсновнойОтветственный");
						//ТекушийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
						//ПользовательСсылка = Справочники.Пользователи.НайтиПоКоду(СокрЛП(ТекушийПользователь));
						Ответственный = ПараметрыСеанса.ТекущийПользователь;
					КонецЕсли;
					ЭлектронныйДокумент.Ответственный= Ответственный; // хорошо бы взять из СоставПакета.Ответственный
	//     * СуммаДокумента - Число - итоговая сумма электронного документа.
				конецесли;
	//СоставПакета.Редакция	Массив	Массив
	//СоставПакета.Событие	Массив	Массив
	//СоставПакета.Состояние	Структура	Структура
	//	Код	"7"	Строка
	//	Название	"Выполнение завершено успешно"	Строка
	//	Описание	""	Строка
	//СсылкаДляКонтрагент	"https://online.sbis.ru/reg/showdoc.html?params=eyJHVUlEIjoiYzg4MWM5MjQtNjkwNC00NTUwLTk4OGMtZDA3MjY1MGQzN2Q0Iiwi0JjQndCd%0AIjoiNjAwMDAwMDAwMSIsItCa0J%2FQnyI6IjYwMDEwMTAwMSJ9"	Строка
	//СсылкаДляНашаОрганизация	"https://online.sbis.ru/opendoc.html?guid=c881c924-6904-4550-988c-d072650d37d4"	Строка
	//СсылкаНаPDF	""	Строка
	//СсылкаНаАрхив	"https://online.sbis.ru/service/?method=%D0%92%D0%B5%D1%80%D1%81%D0%B8%D1%8F%D0%92%D0%BD%D0%B5%D1%88%D0%BD%D0%B5%D0%B3%D0%BE%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0.%D0%A1%D0%BE%D1%85%D1%80%D0%B0%D0%BD%D0%B8%D1%82%D1%8C%D0%9D%D0%B0%D0%94%D0%B8%D1%81%D0%BA%D0%A0%D0%B5%D0%B4%D0%B0%D0%BA%D1%86%D0%B8%D1%8E&params=eyLQmNC00J4iOjM1NDE5Mn0%3D&protocol=3&id=0&srv=1"	Строка
	//Сумма	"17700.00"	Строка
	//СоставПакета.Тип	"ФактураИсх"	Строка
	//СоставПакета.Удален	"Нет"	Строка
				если СоставПакета.свойство("Примечание") тогда
					ЭлектронныйДокумент.Текст= СоставПакета.Примечание;
				конецесли;
				если СоставПакета.Состояние.свойство("Примечание") тогда
					если не значениеЗаполнено(ЭлектронныйДокумент.Текст) тогда
						ЭлектронныйДокумент.Текст= СоставПакета.Состояние.Примечание;
					конецесли;
					ЭлектронныйДокумент.ПричинаОтклонения = СоставПакета.Состояние.Примечание;
				конецесли;
				//ЭлектронныйДокумент.ДатаИзмененияСостоянияЭДО    //СоставПакета.ДатаВремяСоздания	14.09.2017 13:36:12	Дата
				ЭлектронныйДокумент.СостояниеЭДО= СостояниеВерсииЭД;
				ЭлектронныйДокумент.Записать();

				НоваяЗаписьНабора.ЭлектронныйДокумент=ЭлектронныйДокумент.Ссылка;
			иначе
				если значениеЗаполнено(НоваяЗаписьНабора.ЭлектронныйДокумент) тогда
					ЭлектронныйДокумент = НоваяЗаписьНабора.ЭлектронныйДокумент.ПолучитьОбъект();
					ЭлектронныйДокумент.ДатаИзмененияСтатусаЭД=	текущаядата();
					ЭлектронныйДокумент.СтатусЭД			=	статусФайла;
					ЭлектронныйДокумент.Записать();
				иначе
					ЭлектронныйДокумент=Справочники.ЭДПрисоединенныеФайлы.СоздатьЭлемент();
					ЭлектронныйДокумент.Наименование	=	"СБИС";
					если метаданные.Справочники.ЭДПрисоединенныеФайлы.реквизиты.Найти("ВидЭД")<> неопределено тогда
						ЭлектронныйДокумент.ВидЭД = НастройкиЭД.ВидЭД;
					конецесли;
					ЭлектронныйДокумент.ВладелецФайла	=	ДокСсылка;
					ЭлектронныйДокумент.ДатаИзмененияСтатусаЭД=текущаядата();
					ЭлектронныйДокумент.СтатусЭД		=	статусФайла;
					ЭлектронныйДокумент.Описание		=	"обмен через СБИС";
					ЭлектронныйДокумент.Расширение		=	"XML";
					ЭлектронныйДокумент.Записать();
					НоваяЗаписьНабора.ЭлектронныйДокумент=ЭлектронныйДокумент.Ссылка;
				конецесли;
			конецесли;
			попытка
				НаборЗаписей.Записать();
			исключение // Возможно по данному типу документа не предусмотрено ведение состояниеЭД
				Сообщить(ОписаниеОшибки());
			конецпопытки;
		конецесли;
	конецесли;
конецфункции

&НаСервереБезКонтекста
Функция	СоздатьНастройкиЭДО(ДокСсылка)
	параметрыЭД=новый структура("СпособыОбменаЭД,организация, Контрагент,договор",Перечисления.СпособыОбменаЭД.ЧерезКаталог);
	Соглашение = Неопределено;
	ИскомоеСоглашение = Неопределено;
	Если докСсылка.Метаданные().реквизиты.найти("Организация")<> Неопределено тогда 
		параметрыЭД.организация=ДокСсылка.Организация;
	Иначе
		Если докСсылка.Метаданные().реквизиты.найти("ДокументОснование")<> Неопределено
			И ДокСсылка.ДокументОснование.Метаданные().реквизиты.найти("Организация")<> Неопределено тогда 
			параметрыЭД.организация=ДокСсылка.ДокументОснование.Организация;
		КонецЕсли;
	КонецЕсли;
	Если ДокСсылка.Метаданные().реквизиты.найти("Контрагент")<> Неопределено тогда 
		параметрыЭД.Контрагент=ДокСсылка.Контрагент;
	Иначе
		Если ДокСсылка.Метаданные().реквизиты.найти("ДокументОснование")<> Неопределено
			И ДокСсылка.ДокументОснование.Метаданные().реквизиты.найти("Контрагент")<> Неопределено тогда 
			параметрыЭД.Контрагент=ДокСсылка.ДокументОснование.Контрагент;
		КонецЕсли;
	КонецЕсли;
	//Если ДокСсылка.Метаданные().реквизиты.найти("Договор")<> Неопределено тогда 
	//	параметрыЭД.договор=ДокСсылка.Договор;
	//ИначеЕсли ДокСсылка.Метаданные().реквизиты.найти("ДоговорКонтрагента")<> Неопределено тогда 
	// 	параметрыЭД.договор=ДокСсылка.ДоговорКонтрагента;
	//Иначе
	//	Если ДокСсылка.Метаданные().реквизиты.найти("ДокументОснование")<> Неопределено
	//			И ДокСсылка.ДокументОснование.Метаданные().реквизиты.найти("Договор")<> Неопределено тогда 
	//		параметрыЭД.договор=ДокСсылка.ДокументОснование.Договор;
	//	КонецЕсли;
	//КонецЕсли;
	Попытка
		Если ЗначениеЗаполнено(параметрыЭД.организация) И ЗначениеЗаполнено(параметрыЭД.Контрагент) тогда
			УстановитьПривилегированныйРежим(Истина); // Получаем настройки ЭДО безусловно
			
			Запрос = Новый Запрос;
			Запрос.УстановитьПараметр("Организация",параметрыЭД.Организация);
			Запрос.УстановитьПараметр("Контрагент", параметрыЭД.Контрагент);
			Попытка
				ДопустимыеСостояния= новый списокЗначений();
				ДопустимыеСостояния.Добавить(Перечисления.СостоянияСоглашенийЭД.ПроверкаТехническойСовместимости);
				ДопустимыеСостояния.Добавить(Перечисления.СостоянияСоглашенийЭД.Действует);
				Запрос.УстановитьПараметр("ДопустимыеСостояния", ДопустимыеСостояния);
				условияДопустимыеСостояния=" И СоглашенияОбИспользованииЭД.СостояниеСоглашения В(&ДопустимыеСостояния)" 
			Исключение
				условияДопустимыеСостояния="";
			КонецПопытки;
			
			Если ЗначениеЗаполнено(параметрыЭД.договор) И метаданные.справочники.СоглашенияОбИспользованииЭД.реквизиты.найти("ДоговорКонтрагента")<> Неопределено тогда 
				Запрос.Текст ="ВЫБРАТЬ
				|	СоглашенияОбИспользованииЭД.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.СоглашенияОбИспользованииЭД КАК СоглашенияОбИспользованииЭД
				|ГДЕ
				|	СоглашенияОбИспользованииЭД.Контрагент = &Контрагент
				|	И СоглашенияОбИспользованииЭД.ДоговорКонтрагента = &ДоговорКонтрагента
				|	И СоглашенияОбИспользованииЭД.Организация = &Организация
				|	И НЕ СоглашенияОбИспользованииЭД.ПометкаУдаления
				|	И СоглашенияОбИспользованииЭД.СтатусСоглашения = ЗНАЧЕНИЕ(Перечисление.СтатусыСоглашенийЭД.Действует)"+условияДопустимыеСостояния;
				Запрос.УстановитьПараметр("ДоговорКонтрагента", параметрыЭД.Договор);
				Выборка = Запрос.Выполнить().Выбрать();
				Выборка.Следующий();
				Соглашение=Выборка.Ссылка;
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Соглашение) тогда
				Запрос.Текст ="ВЫБРАТЬ
				|	СоглашенияОбИспользованииЭД.Ссылка
				|ИЗ
				|	Справочник.СоглашенияОбИспользованииЭД КАК СоглашенияОбИспользованииЭД
				|ГДЕ
				|	СоглашенияОбИспользованииЭД.Контрагент = &Контрагент
				|	И СоглашенияОбИспользованииЭД.Организация = &Организация
				|	И НЕ СоглашенияОбИспользованииЭД.ПометкаУдаления
				|	И СоглашенияОбИспользованииЭД.СтатусСоглашения = ЗНАЧЕНИЕ(Перечисление.СтатусыСоглашенийЭД.Действует)"+условияДопустимыеСостояния;
				Выборка = Запрос.Выполнить().Выбрать();
				Выборка.Следующий();
				Соглашение=Выборка.Ссылка;
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Соглашение) И метаданные.РегистрыСведений.найти("УчастникиОбменовЭДЧерезОператоровЭДО")<> Неопределено тогда
				Запрос.Текст ="ВЫБРАТЬ
				|	СоглашениеЧерезОЭДО.Ссылка
				|ИЗ
				|	РегистрСведений.УчастникиОбменовЭДЧерезОператоровЭДО КАК УчастникиОбменовЭДЧерезОператоровЭДО
				|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СоглашенияОбИспользованииЭД КАК СоглашениеЧерезОЭДО
				|		ПО УчастникиОбменовЭДЧерезОператоровЭДО.СоглашениеОбИспользованииЭД = СоглашениеЧерезОЭДО.Ссылка
				|ГДЕ
				|	НЕ СоглашениеЧерезОЭДО.ПометкаУдаления
				|	И СоглашениеЧерезОЭДО.СтатусСоглашения = ЗНАЧЕНИЕ(Перечисление.СтатусыСоглашенийЭД.Действует)
				|	И СоглашениеЧерезОЭДО.Организация = &Организация
				|	И УчастникиОбменовЭДЧерезОператоровЭДО.Участник = &Контрагент
				|	И УчастникиОбменовЭДЧерезОператоровЭДО.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыУчастниковОбменаЭД.Присоединен)";
				Выборка = Запрос.Выполнить().Выбрать();
				Выборка.Следующий();
				Соглашение=Выборка.Ссылка;
			КонецЕсли;
			Если ЗначениеЗаполнено(Соглашение) тогда
				ИскомоеСоглашение = Соглашение.ПолучитьОбъект();
				Если Не ЗначениеЗаполнено(ИскомоеСоглашение.Комментарий) тогда
					ИскомоеСоглашение.Комментарий	=	"СБИС";
				КонецЕсли;
				ЗаписатьОбъект = Ложь;
			Иначе // создать новое
				ИскомоеСоглашение= Справочники.СоглашенияОбИспользованииЭД.СоздатьЭлемент();
				ИскомоеСоглашение.наименование	=	"СБИС";
				ИскомоеСоглашение.Комментарий	=	"СБИС";
				ИскомоеСоглашение.Организация	=	параметрыЭД.Организация;
				ИскомоеСоглашение.Контрагент	=	параметрыЭД.Контрагент;
				ИскомоеСоглашение.СтатусСоглашения= Перечисления.СтатусыСоглашенийЭД.Действует;
				ИскомоеСоглашение.СпособОбменаЭД = параметрыЭД.СпособыОбменаЭД;
				Если ИскомоеСоглашение.Метаданные().Реквизиты.Найти("ДоговорКонтрагента")<> Неопределено тогда
					ИскомоеСоглашение.ДоговорКонтрагента=параметрыЭД.Договор;
				КонецЕсли;
				Если ИскомоеСоглашение.Метаданные().Реквизиты.Найти("СостояниеСоглашения")<> Неопределено тогда
					ИскомоеСоглашение.СостояниеСоглашения=Перечисления.СостоянияСоглашенийЭД.Действует;
				КонецЕсли;
				Если ИскомоеСоглашение.Метаданные().Реквизиты.Найти("СтатусПодключения")<> Неопределено тогда
					ИскомоеСоглашение.СтатусПодключения= Перечисления.СтатусыУчастниковОбменаЭД.Присоединен;
				КонецЕсли;
				если ИскомоеСоглашение.Метаданные().Реквизиты.Найти("ИспользуетсяДляОтправки")<> неопределено тогда
					ИскомоеСоглашение.ИспользуетсяДляОтправки= истина;
				конецесли;
				ЗаписатьОбъект = истина;
			КонецЕсли;
			
			Если ИскомоеСоглашение.Метаданные().реквизиты.найти("ПрофильНастроекЭДО")<> Неопределено тогда 
				Если Не ЗначениеЗаполнено(ИскомоеСоглашение.ПрофильНастроекЭДО) тогда
					отбор=новый структура("наименование,Организация,СпособОбменаЭД","СБИС",параметрыЭД.Организация,параметрыЭД.СпособыОбменаЭД);
					Запрос.Текст ="ВЫБРАТЬ
					|	профили.Ссылка
					|ИЗ
					|	Справочник.ПрофилиНастроекЭДО КАК профили
					|ГДЕ
					|	профили.наименование = &наименование
					|	И профили.Организация = &Организация
					|	И профили.СпособОбменаЭД = &СпособОбменаЭД 
					|	И НЕ профили.ПометкаУдаления";
					Запрос.УстановитьПараметр("наименование", отбор.наименование);
					Запрос.УстановитьПараметр("СпособОбменаЭД", отбор.СпособОбменаЭД);
					Выборка = Запрос.Выполнить().Выбрать();
					
					Если Выборка.Следующий() тогда
						профильСБИС= Выборка.Ссылка;
					Иначе
						профильСБИС=Справочники.ПрофилиНастроекЭДО.СоздатьЭлемент();
						заполнитьЗначенияСвойств(профильСБИС,отбор);
						//для каждого ЭлементПеречисления Из Метаданные.Перечисления.ВидыЭД.ЗначенияПеречисления цикл
						//	НоваяСтрока = профильСБИС.ИсходящиеДокументы.Добавить();
						//	НоваяСтрока.ИсходящийДокумент = ЭлементПеречисления;
						//	Перечисления.ВидыЭД.(ЭлементПеречисления.имя)
						//	НоваяСтрока.Формировать       = истина;
						//конеццикла;
						профильСБИС.Записать();
					КонецЕсли;
					ИскомоеСоглашение.ПрофильНастроекЭДО=профильСБИС.Ссылка;
					ЗаписатьОбъект = истина;
				КонецЕсли;
			КонецЕсли;
			
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12Продавец, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12Покупатель, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.АктИсполнитель, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.АктЗаказчик, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.СчетФактура, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ПроизвольныйЭД, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Исходящий",ИскомоеСоглашение, Перечисления.ВидыЭД.СчетНаОплату, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12Продавец, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.ТОРГ12Покупатель, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.АктВыполненныхРабот, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.СчетФактура, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			Если ПроверитьВидЭД("Входящий",ИскомоеСоглашение, Перечисления.ВидыЭД.СчетНаОплату, параметрыЭД.СпособыОбменаЭД) тогда
				ЗаписатьОбъект = Истина;
			КонецЕсли;
			
			Если ЗаписатьОбъект Тогда
				Попытка
					ИскомоеСоглашение.Записать();
				Исключение
					Сообщить("ДоговорКонтрагента "+ИскомоеСоглашение.ДоговорКонтрагента);
					Попытка
						Для каждого Реквизит Из ИскомоеСоглашение.Метаданные().Реквизиты Цикл
							Сообщить(Реквизит.Имя + " " + ИскомоеСоглашение[Реквизит]);
						КонецЦикла;
					Исключение
					КонецПопытки;
					ИскомоеСоглашение = Неопределено;
				КонецПопытки;
			КонецЕсли;
		КонецЕсли;
	Исключение
		Сообщить("неудачное создание настройки ЭДО :"+ОписаниеОшибки());
	КонецПопытки;
	Если ИскомоеСоглашение = Неопределено тогда
		Возврат ИскомоеСоглашение;
	Иначе
		Возврат ИскомоеСоглашение.Ссылка;
	КонецЕсли;
конецФункции

&НаСервереБезКонтекста
Функция ОпределитьНастройкиОбменаЭДПоИсточнику(Источник,
				ВыводитьСообщения = Ложь,
				ПараметрыСертификатов = Неопределено,
				ЭД = Неопределено,
				ВидЭД = Неопределено)
	Если не значениеЗаполнено(ВидЭД) тогда
		Попытка
			ПараметрыЭД = вычислить("ОбменСКонтрагентамиСлужебный.ЗаполнитьПараметрыЭДПоИсточнику(Источник, истина)");
		Исключение
			Ошибка = ОписаниеОшибки();
			Попытка
				ПараметрыЭД = Новый структура("ВидЭД,НаправлениеЭД,Организация,Контрагент,ДоговорКонтрагента");
				выполнить("ЭлектронныеДокументыПереопределяемый.ЗаполнитьПараметрыЭДПоИсточнику(Источник, ПараметрыЭД, истина)");
			Исключение
				Ошибка = Ошибка+" "+ОписаниеОшибки();
				сообщить("Форма работы со статусами 'Статусы_СостоянияЭД' не поддерживается для данной конфигурации "+ Ошибка);
				НастройкиЭД=ложь;
			КонецПопытки;	
		КонецПопытки;	
		Если ЗначениеЗаполнено(ПараметрыЭД.ВидЭД) тогда
			ВидЭД= ПараметрыЭД.ВидЭД;
		иначе
			ВидЭД= перечисления.видыЭД.ПроизвольныйЭД;
		конецЕсли;
	конецЕсли;
	Попытка
		ИсполняемыеПараметры = Новый Структура("ВыводитьСообщения, МассивОтпечатковСертификатов, ВидЭД, ФлагДействующиеСоглашения", 
			Истина, ПараметрыСертификатов, ВидЭД, Истина);
		НастройкиЭД =вычислить("ОбменСКонтрагентамиСлужебный.ОпределитьНастройкиОбменаЭДПоИсточнику(Источник,ИсполняемыеПараметры)");		
	Исключение
		Ошибка = ОписаниеОшибки();
		Попытка
			НастройкиЭД =вычислить("ЭлектронныеДокументыСлужебный.ОпределитьНастройкиОбменаЭДПоИсточнику(Источник,ВыводитьСообщения,ПараметрыСертификатов,ЭД,ВидЭД)");
		Исключение
			Ошибка = Ошибка+" "+ОписаниеОшибки();
			сообщить("Форма работы со статусами 'Статусы_СостоянияЭД' не поддерживается для данной конфигурации "+ Ошибка);
			НастройкиЭД=ложь;
		КонецПопытки;	
	КонецПопытки;	
	возврат НастройкиЭД;
конецфункции

&НаСервереБезКонтекста       
Функция	ПроверитьВидЭД(Направление, ИскомоеСоглашение, ВидЭД, СпособыОбменаЭД)
	Если Направление="Входящий" тогда
		ПолеВидЭД="ВходящийДокумент";
		ТЧ_ЭлДокументы="ВходящиеДокументы";
	Иначе
		ПолеВидЭД="ИсходящийДокумент";
		ТЧ_ЭлДокументы="ИсходящиеДокументы";
	КонецЕсли;
	ЗаписатьОбъект=Ложь;
	строкаЭД = ИскомоеСоглашение[ТЧ_ЭлДокументы].Найти(ВидЭД, ПолеВидЭД);
	ЕстьСпособОбменаЭД= (ИскомоеСоглашение.Метаданные().ТабличныеЧасти[ТЧ_ЭлДокументы].Реквизиты.Найти("СпособОбменаЭД")<> Неопределено);
	Если строкаЭД = Неопределено Тогда
		строкаЭД = ИскомоеСоглашение[ТЧ_ЭлДокументы].Добавить();
		строкаЭД[ПолеВидЭД]       = ВидЭД;
		Если ЕстьСпособОбменаЭД тогда
			строкаЭД.СпособОбменаЭД		= СпособыОбменаЭД;
		КонецЕсли;
		строкаЭД.Формировать             = истина;
		ЗаписатьОбъект = Истина;
	Иначе
		Если Не строкаЭД.Формировать тогда
			строкаЭД.Формировать=Истина;
			ЗаписатьОбъект = Истина;
		КонецЕсли;
		Если ЕстьСпособОбменаЭД тогда
			Если строкаЭД.СпособОбменаЭД	<> СпособыОбменаЭД тогда
				строкаЭД.СпособОбменаЭД = СпособыОбменаЭД;
				ЗаписатьОбъект = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	Возврат ЗаписатьОбъект;
конецФункции
