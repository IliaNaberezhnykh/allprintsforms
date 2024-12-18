////////////////////////////////////////////////////////////////////////////////
// ПЕРЕМЕННЫЕ МОДУЛЯ

&НаСервере
Перем ОбработкаОбъект;


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	ИнициализироватьФорму(Параметры);
	
КонецПроцедуры  

// Служебный метод для передачи параметров формы.
//
&НаСервере
Процедура ИнициализироватьФорму(ПараметрыФормы) Экспорт
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	Заголовок								 = ПараметрыФормы.ЗаголовокФормы;
	ИдентификаторЯщика						 = ПараметрыФормы.ИдентификаторЯщика;
	ЗаголовокКнопкиДействия					 = ПараметрыФормы.ЗаголовокКнопкиДействия;
	ДействиеЭДО								 = ПараметрыФормы.ДействиеЭДО;
	КатегорияМетрикиДокумента				 = ПараметрыФормы.КатегорияМетрикиДокумента;
	TraceId									 = Модуль_Ядро.TraceId();
	КонтрагентПоддерживаетМЧД				 = ПараметрыФормы.КонтрагентПоддерживаетМЧД;
	
	ПредставлениеПодписанта = Модуль_Ядро.Подписант_ПредставлениеПодписанта(ИдентификаторЯщика);
	
	НастроитьЭлементыЭтойФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Метрика_НаДействияСФормой(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы = Истина Тогда
		Возврат;
	КонецЕсли;
	
	Метрика_НаДействияСФормой(Ложь);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЕРВИСНЫЕ МЕТОДЫ

&НаСервере
Функция ОбработкаОбъект()

	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки = ПолучитьИзВременногоХранилища(Объект.ОбщийКонтекстКлиентСервер.АдресОбработкаОбъект);
		Если Не СтруктураОбработки = Неопределено Тогда
			ОбработкаОбъект = СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			
			ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
			Попытка
				ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), Объект.ОбщийКонтекстКлиентСервер.АдресОбработкаОбъект);
			Исключение
			КонецПопытки;
			
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат ОбработкаОбъект;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма() Экспорт
	
	Результат = ВладелецФормы.ОсновнаяФорма();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция Модуль_ЯдроНаСервере()
	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Модуль_ЯдроНаКлиенте()
	
	Результат = ОсновнаяФорма().Модуль_ЯдроНаКлиенте();
	
	Возврат Результат;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД

&НаКлиенте
Процедура ВыполнитьДействие(Команда)
	
	ОсновнаяФорма = ОсновнаяФорма();
	Оповещение				 = ОсновнаяФорма.НовыйОписаниеОповещения("ВыполнитьДействиеПослеПроверкиМЧД", ЭтаФорма);
	КонтрактВыбраннойМЧД	 = КонтекстМЧД.СписокМЧД.Получить(ВыбраннаяМЧД);
	ПараметрыДляПроверкиМЧД	 = ОсновнаяФорма.ПараметрыДляПроверкиМЧД(Оповещение, ИдентификаторЯщика, КонтрактВыбраннойМЧД, ДействиеЭДО);
	
	ДопПеременные = Метрика_ОбщиеДополнительныеПараметры(ПараметрыДляПроверкиМЧД);
	
	ДействияЭДО			 = ОсновнаяФорма.ДействияЭДО();
	НазванияДействийЭДО	 = ОсновнаяФорма.Метрика_НазваниеДействий();

	Если ДействиеЭДО = ДействияЭДО.ЗапроситьУточнение Тогда
		ДействиеМетрики = НазванияДействийЭДО.ЗапроситьУточнение;
	ИначеЕсли ДействиеЭДО = ДействияЭДО.Аннулировать Тогда
		ДействиеМетрики = НазванияДействийЭДО.Аннулировать;	
	ИначеЕсли ДействиеЭДО = ДействияЭДО.ОтказатьВАннулировании Тогда
		ДействиеМетрики = НазванияДействийЭДО.ОтказатьВАннулировании;
	Иначе
		ДействиеМетрики = ЗаголовокКнопкиДействия;
	КонецЕсли;
	
	КатегорияМетрики			 = КатегорияМетрикиДокумента;
	НазваниеФормыМетрики		 = НазваниеФормы(); 
	ЛейблМетрики				 = НазванияДействийЭДО.НажатиеКнопки;
	ПредставлениеМетрики		 = ПредставлениеНазванияФормы();
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормыМетрики, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , ДопПеременные, ПредставлениеМетрики, TraceId);
	
	Если КонтрагентПоддерживаетМЧД Тогда
		ОсновнаяФорма.ПроверитьМЧДИВыполнитьОповещение(ПараметрыДляПроверкиМЧД);
	Иначе
		РезультатВыбораМЧД = ОсновнаяФорма().РезультатВыбораМЧД(Истина, Неопределено);
		ОсновнаяФорма.ВыполнитьОбработкуОповещенияПереопределенная(Оповещение, РезультатВыбораМЧД);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьДействиеПослеПроверкиМЧД(Результат, ДополнительныеПараметры) Экспорт
	
	РазрешитьДействие = ОсновнаяФорма().СвойствоСтруктуры(Результат, "РазрешитьДействие");
	
	Если РазрешитьДействие Тогда
		Закрыть(Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьМЧД(Команда)
	
	Метрика_НастроитьМЧД();
	ОсновнаяФорма().ОткрытьФормуСпискаДоверенностей(ИдентификаторЯщика);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбраннаяМЧДПриИзменении(Элемент) 
	
	Метрика_ВыбраннаяМЧДПриИзменении();

КонецПроцедуры

&НаКлиенте
Процедура ВыбраннаяМЧДОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(ВыбраннаяМЧД) Тогда
		КонтрактМЧД = КонтекстМЧД.СписокМЧД.Получить(ВыбраннаяМЧД);
		ОсновнаяФорма().МЧД_ПоказатьСведенияОДоверенности(КонтрактМЧД, ЭтаФорма);
		Метрика_ПоказатьСведенияОДоверенности();
	КонецЕсли;

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура НастроитьЭлементыЭтойФормы()

	Модуль_Ядро = Модуль_ЯдроНаСервере();
	КоллекцияКартинок = Модуль_Ядро.БиблиотекаКартинок();
	
	КартинкаСертификата = КоллекцияКартинок.КартинкаЛокальныйСертификат;
	АдресКартинкиПодписанта = ПоместитьВоВременноеХранилище(КартинкаСертификата, УникальныйИдентификатор);
	
	Элементы.ВыполнитьДействие.Заголовок = ЗаголовокКнопкиДействия;
	
	НастроитьМЧДНаФорме();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьМЧДНаФорме()
	
	Если КонтрагентПоддерживаетМЧД Тогда
		ЗаполнитьСписокДоступныхМЧД(ИдентификаторЯщика);
		Элементы.ГруппаКонтрагентНеПоддерживаетМЧД.Видимость = Ложь;
	Иначе
		ЗаполнитьСписокДоступныхМЧД("");
		Элементы.ГруппаМЧД.Видимость = Ложь;
		Элементы.ГруппаКонтрагентНеПоддерживаетМЧД.Видимость = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоступныхМЧД(BoxID)
	
	КонтекстМЧД			 = Модуль_ЯдроНаСервере().МЧД_ДанныеПоИспользованиюДоверенностей(BoxID);
	СписокВыбораМЧД		 = Элементы.ВыбраннаяМЧД.СписокВыбора;
	
	Для Каждого КлючЗначение Из КонтекстМЧД.СписокМЧД Цикл
		ДанныеМЧД = КлючЗначение.Значение;
		СписокВыбораМЧД.Добавить(ДанныеМЧД.Идентификатор, ДанныеМЧД.ПредставлениеМЧД);
	КонецЦикла;
	
	ВыбраннаяМЧД = КонтекстМЧД.МЧД;
	
КонецПроцедуры

&НаКлиенте
Функция НазваниеФормы()
	
	Результат = "ФормаВыбораМЧД";
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПредставлениеНазванияФормы()

	Возврат "Форма выбора МЧД";

КонецФункции 

&НаКлиенте
Процедура Метрика_НаДействияСФормой(ЭтоОткрытиеФормы)
	
	ДопПеременные = Метрика_ОбщиеДополнительныеПараметры();
	
	Если ЭтоОткрытиеФормы Тогда
		ДействиеМетрики			= ОсновнаяФорма().Метрика_НазваниеДействий().ОткрытиеФормы;
	Иначе
		ДействиеМетрики			= ОсновнаяФорма().Метрика_НазваниеДействий().ЗакрытиеФормы;
	КонецЕсли;
	
	НазваниеФормыДляМетрики = НазваниеФормы();
	КатегорияМетрики		= ОсновнаяФорма().Метрика_НазваниеКатегории().ВыборДоверенности;
	ЛейблМетрики			= ОсновнаяФорма().Метрика_НазваниеДействий().НажатиеКнопки;
	ПредставлениеМетрики	= ПредставлениеНазванияФормы();
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_ДействиеСФормой(НазваниеФормыДляМетрики, КатегорияМетрики, ЭтоОткрытиеФормы, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , ДопПеременные, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Функция Метрика_ОбщиеДополнительныеПараметры(ПараметрыДляПроверкиМЧД = Неопределено)
	
	Если НЕ ЗначениеЗаполнено(ПараметрыДляПроверкиМЧД) Тогда
		КонтрактВыбраннойМЧД		 = КонтекстМЧД.СписокМЧД.Получить(ВыбраннаяМЧД);
		ПараметрыДляПроверкиМЧД		 = ОсновнаяФорма().ПараметрыДляПроверкиМЧД(Неопределено, ИдентификаторЯщика, КонтрактВыбраннойМЧД, ДействиеЭДО);
	КонецЕсли;
	
	Результат = ОсновнаяФорма().Метрика_ДополнительныеПеременныеМЧД(ПараметрыДляПроверкиМЧД);
	
	Возврат Результат;
	
КонецФункции 

&НаКлиенте
Процедура Метрика_НастроитьМЧД()
	
	КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().ВыборДоверенности;
	ДействиеМетрики		= ОсновнаяФорма().Метрика_НазваниеДействий().НастроитьДоверенности;
	НазваниеФормы		= НазваниеФормы();
	ЛейблМетрики		= ОсновнаяФорма().Метрика_НазваниеДействий().НажатиеКнопки;
	ПредставлениеМетрики= ПредставлениеНазванияФормы();
	ДопПеременные		= Метрика_ОбщиеДополнительныеПараметры();
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , ДопПеременные, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ВыбраннаяМЧДПриИзменении()
	
	КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().ВыборДоверенности;
	ДействиеМетрики		= ОсновнаяФорма().Метрика_НазваниеДействий().РедактироватьПоле;
	НазваниеФормы		= НазваниеФормы();
	ЛейблМетрики		= ОсновнаяФорма().Метрика_НазваниеДействий().НажатиеКнопки;
	ПредставлениеМетрики= ПредставлениеНазванияФормы();
	ДопПеременные		= Метрика_ОбщиеДополнительныеПараметры();
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , ДопПеременные, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ПоказатьСведенияОДоверенности()
	
	КатегорияМетрики = Метрика_НазванияКатегорий().ВыборДоверенности;
	ДействиеМетрики	= Метрика_НазванияДействий().ПосмотретьДоверенность;
	НазваниеФормы = НазваниеФормы();
	ПредставлениеМетрики = ПредставлениеНазванияФормы();
	
	ДопПеременные = Новый Соответствие;
	ДопПеременные.Вставить("Рег.номер МЧД", ВыбраннаяМЧД);
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики, , ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , ДопПеременные, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, НазваниеКатегории, НазваниеКнопки, НазваниеМетки = "", ПредставлениеМетрики = "", TraceId = "")
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, НазваниеКатегории, НазваниеКнопки, НазваниеМетки, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, НазваниеМетки = Неопределено, ДопПеременные = Неопределено, ПредставлениеМетрики = "", TraceId = "")
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, НазваниеМетки, ДопПеременные, ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Функция Метрика_НазванияДействий()
	
	ОсновнаяФорма = ОсновнаяФорма();
	Результат = ОсновнаяФорма.Метрика_НазваниеДействий();
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Метрика_НазванияКатегорий()
	
	ОсновнаяФорма = ОсновнаяФорма();
	Результат = ОсновнаяФорма.Метрика_НазваниеКатегории();
	Возврат Результат;
	
КонецФункции


