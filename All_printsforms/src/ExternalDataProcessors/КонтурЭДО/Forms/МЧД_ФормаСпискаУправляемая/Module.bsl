////////////////////////////////////////////////////////////////////////////////
// ПЕРЕМЕННЫЕ МОДУЛЯ

&НаСервере
Перем ОбработкаОбъект;


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Перем СписокОрганизаций;
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	ЗаполнитьСписокВыбораОрганизацийНаФорме(СписокОрганизаций);
	
	ИдентификаторЯщика = Параметры.ИдентификаторЯщика;
	
	НастроитьЭлементыФормы();
	
	ОбновитьСписокДоверенностей();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	КатегорияМетрики		 = Метрика_НазваниеКатегории().НастройкиДоверенности;
	НазваниеФормыДляМетрики	 = Метрика_НазваниеФормы();
	ПредставлениеМетрики	 = Метрика_НазваниеФормы(); 
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_ДействиеСФормой(НазваниеФормыДляМетрики, КатегорияМетрики, Истина, Метрика_НазваниеДействий().НажатиеКнопки, ПредставлениеМетрики);
	
	ДопПеременные			 = Новый Соответствие;
	ДопПеременные.Вставить("Кол-во доверенностей", СписокДоверенностей.Количество());
	TraceId					 = Модуль_ЯдроНаКлиенте().TraceId();
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, Метрика_НазваниеДействий().ОткрытиеФормы, , ДопПеременные, , TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы = Истина Тогда
		Возврат;
	КонецЕсли;
	
	КатегорияМетрики		 = Метрика_НазваниеКатегории().НастройкиДоверенности;
	НазваниеФормыДляМетрики	 = Метрика_НазваниеФормы();
	ПредставлениеМетрики	 = Метрика_НазваниеФормы();
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_ДействиеСФормой(НазваниеФормыДляМетрики, КатегорияМетрики, Ложь, Метрика_НазваниеДействий().НажатиеКнопки, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, Метрика_НазваниеДействий().ОткрытиеФормы, , , , TraceId);
	
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

&НаКлиенте
Функция Модуль_ЯдроНаКлиенте()
	
	Результат = ОсновнаяФорма().Модуль_ЯдроНаКлиенте();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция Модуль_ЯдроНаСервере()
	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД

&НаКлиенте
Процедура ОбновитьДанные(Команда)
	
	Метрика_НажатиеКнопки(Метрика_НазваниеДействий().ОбновитьДанные, Неопределено);
	
	ОбновитьСписокДоверенностей();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыпуститьНовую(Команда)

	Метрика_НажатиеКнопки(Метрика_НазваниеДействий().ВыпуститьНовую, Неопределено);
	
	Ссылка = СсылкаНаСтраницуВыпускаНовойМЧД();
	ЗапуститьПриложение(Ссылка);	

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьВВебВерсииДиадока(Команда)

	Метрика_НажатиеКнопки(Метрика_НазваниеДействий().ЗагрузитьВДиадоке, Неопределено);
	
	Ссылка = СсылкаНаСтраницуЗагрузкиМЧД();
	ЗапуститьПриложение(Ссылка);

КонецПроцедуры  

&НаКлиенте
Процедура ДобавитьДоверенность(Команда)
	
	Метрика_ДобавитьДоверенностьНажатие();
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ИдентификаторЯщика", ИдентификаторЯщика);
	
	ОписаниеОповещения = ОсновнаяФорма().НовыйОписаниеОповещения("ДобавитьДоверенностьЗавершение", ЭтаФорма);
	
	ОсновнаяФорма().ОткрытьФормуДиадокМодально("МЧД_ФормаДобавленияУправляемая", ЭтаФорма, ПараметрыФормы, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьДоверенностьЗавершение(Результат, ДополнительныеПараметры = Неопределено) Экспорт
	
	ОбновитьСписокДоверенностей();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура СписокОрганизацийПриИзменении(Элемент)
	
	ОбновитьСписокДоверенностей();
	
	ДопПеременные			 = Новый Соответствие;
	ДопПеременные.Вставить("Кол-во доверенностей", СписокДоверенностей.Количество());
	ДействиеМетрики			 = Метрика_НазваниеДействий().ИзменитьОтбор;
	Метрика_НажатиеКнопки(ДействиеМетрики, ДопПеременные);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДоверенностейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = СписокДоверенностей.НайтиПоИдентификатору(ВыбраннаяСтрока);
	
	Если Поле = Элементы.СписокДоверенностейПоУмолчанию Тогда
		ОбработкаВыбораДоверенностиПоУмолчанию(ТекущиеДанные, СтандартнаяОбработка);
	ИначеЕсли Поле = Элементы.СписокДоверенностейПолномочияИРеквизиты Тогда
		ОбработкаОткрытияДетальнойИнформацииПоДоверенности(ТекущиеДанные, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КартинкаГиперссылкиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ГиперссылкаКакДобавитьДоверенностьНажатие(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаКакДобавитьДоверенностьНажатие(Элемент)

	Метрика_НажатиеКнопки(Метрика_НазваниеДействий().ОткрытьИнструкцию, Неопределено);
	
	Ссылка = СсылкаНаСтраницуИнструкцииПоДобавлениюМЧД();
	ЗапуститьПриложение(Ссылка);

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура ЗаполнитьСписокВыбораОрганизацийНаФорме(СписокОрганизаций)
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	СписокОрганизаций = Модуль_Ядро.Организации_СписокОрганизацийДляВыбора(Ложь);
	
	СписокВыбора = Элементы.ИдентификаторЯщика.СписокВыбора;
	
	Для Каждого ТекОрганизация Из СписокОрганизаций Цикл
		
		ИдентификаторТекОрганизации = Модуль_Ядро.АдресЯщикаВИдентификатор(ТекОрганизация.Значение);
		
		НовыйЭлемент = СписокВыбора.Добавить();
		НовыйЭлемент.Значение		= ИдентификаторТекОрганизации;
		НовыйЭлемент.Представление	= ТекОрганизация.Представление;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСписокДоверенностей()
	
	СписокДоверенностей.Очистить();
	
	Ядро = Модуль_ЯдроНаСервере();
	
	Доверенности = Ядро.МЧД_СписокДоверенностей(ИдентификаторЯщика);
	
	КонтрактыМЧД = Новый ФиксированноеСоответствие(Доверенности);
	
	ЗаполнитьСписокДоверенностей();
	
	Если СписокДоверенностей.Количество() Тогда
		ПоказатьСтраницуСпискаДоверенностей()
	Иначе
		ПоказатьСтраницуИнформацииОбОтсутствииДоверенностей()
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьСтраницуСпискаДоверенностей()
	
	ГруппаДоверенности = Элементы.ГруппаДоверенности;
	ГруппаДоверенности.ТекущаяСтраница = ГруппаДоверенности.ПодчиненныеЭлементы.ГруппаСписок;
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьСтраницуИнформацииОбОтсутствииДоверенностей()
	
	ГруппаДоверенности = Элементы.ГруппаДоверенности;
	ГруппаДоверенности.ТекущаяСтраница = ГруппаДоверенности.ПодчиненныеЭлементы.ГруппаИнформация;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоверенностей()
	
	СписокДоверенностей.Очистить();
	
	Для Каждого ЭлементСпискаМЧД Из КонтрактыМЧД Цикл
		
		КонтрактМЧД = ЭлементСпискаМЧД.Значение;
		
		НоваяСтрока = СписокДоверенностей.Добавить();
		НоваяСтрока.Идентификатор	= КонтрактМЧД.Идентификатор;
		НоваяСтрока.ПоУмолчанию 	= КонтрактМЧД.ПоУмолчанию;
		НоваяСтрока.СрокДействия 	= КонтрактМЧД.СрокДействия;
	
		ОсталосьДоОкончанияСрокаДействияДней = (КонтрактМЧД.СрокДействия - ТекущаяДата()) / (24 * 60 * 60);
		Если ОсталосьДоОкончанияСрокаДействияДней <= 30 Тогда
			НоваяСтрока.ИстекаетСрок = Истина;
		КонецЕсли;
		
		НоваяСтрока.ПредставлениеПредставителяИДоверителя = ПредставлениеПредставителяИДоверителя(КонтрактМЧД); 
		
		НоваяСтрока.ПолномочияИРеквизиты = АдресВХранилищеКартинкиИнформацияПоДоверенности;
		Если НоваяСтрока.ПоУмолчанию Тогда
			НоваяСтрока.КартинкаДоверенностьПоУмолчанию = АдресВХранилищеКартинкиОсновнаяДоверенность;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПредставлениеПредставителяИДоверителя(КонтрактМЧД)
	
	Результат = "";
	
	Ядро = Модуль_ЯдроНаСервере();
	
	ШаблонДоверитель = НСтр("ru='%1, %2'");
	
	Представитель = КонтрактМЧД.Представитель.Наименование;
	
	Доверитель = Ядро.Общее_ПодставитьПараметрыВСтроку(
		ШаблонДоверитель,
		КонтрактМЧД.Доверитель.Наименование,
		КонтрактМЧД.Доверитель.ИНН
	);
	
	ШаблонРезультат = НСтр("ru='%1%2%3'");
	
	Результат = Ядро.Общее_ПодставитьПараметрыВСтроку(
		ШаблонРезультат,
		Представитель,
		Символы.ПС,
		Доверитель
	);
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	Элементы.ГруппаДобавитьДоверенность.Видимость = Ложь;
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	КоллекцияКартинок = Модуль_Ядро.БиблиотекаКартинок();
	
	КартинкаИнформацииПоМЧД = КоллекцияКартинок.КартинкаДанныеСертификата;
	АдресВХранилищеКартинкиИнформацияПоДоверенности = ПоместитьВоВременноеХранилище(КартинкаИнформацииПоМЧД, УникальныйИдентификатор);
	
	КартинкаМЧДпоУмолчанию = КоллекцияКартинок.КартинкаПодразделениеПоУмолчанию;
    АдресВХранилищеКартинкиОсновнаяДоверенность = ПоместитьВоВременноеХранилище(КартинкаМЧДпоУмолчанию, УникальныйИдентификатор);
	
	КартинкаПоиск = КоллекцияКартинок.КартинкаПоиск64;
	АдресВХранилищеКартинкиПоиск = ПоместитьВоВременноеХранилище(КартинкаПоиск, УникальныйИдентификатор);
	
	КартинкаИнструкция = КоллекцияКартинок.КартинкаИнструкцияСиняяКруглая;
	АдресВХранилищеКартинкиИнструкция = ПоместитьВоВременноеХранилище(КартинкаИнструкция, УникальныйИдентификатор);
	
	УстановитьНастройкиЭлементовФормыДляПлатформыВыше8_3_7();
	
	УстановитьУсловноеОформление();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНастройкиЭлементовФормыДляПлатформыВыше8_3_7()

	СвойстваЭлементаФормы = Новый Структура;
	
	СвойстваЭлементаФормы.Вставить("ГоризонтальноеПоложениеПодчиненных"	, ГоризонтальноеПоложениеЭлемента.Центр);
	СвойстваЭлементаФормы.Вставить("ВертикальноеПоложениеВГруппе"		, ВертикальноеПоложениеЭлемента.Центр);
	
	СвойстваЭлементаФормы.Вставить("АвтоМаксимальнаяШирина", Ложь);
	СвойстваЭлементаФормы.Вставить("АвтоМаксимальнаяВысота", Ложь);

	ЗаполнитьЗначенияСвойств(Элементы.ГруппаТекстаНетДоверенности, СвойстваЭлементаФормы);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = ЭлементОформления.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("СписокДоверенностейСрокДействия");
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных")); 
	ЭлементОтбора.ЛевоеЗначение		 = Новый ПолеКомпоновкиДанных("СписокДоверенностей.ИстекаетСрок"); 
	ЭлементОтбора.ВидСравнения		 = ВидСравненияКомпоновкиДанных.Равно; 
	ЭлементОтбора.ПравоеЗначение	 = Истина;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", Новый Цвет(246, 156, 0));
	
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = ЭлементОформления.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("СписокДоверенностейПоУмолчанию");
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных")); 
	ЭлементОтбора.ЛевоеЗначение		 = Новый ПолеКомпоновкиДанных("СписокДоверенностей.ПоУмолчанию"); 
	ЭлементОтбора.ВидСравнения		 = ВидСравненияКомпоновкиДанных.Равно; 
	ЭлементОтбора.ПравоеЗначение	 = Истина;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", Новый Цвет(85, 85, 85));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораДоверенностиПоУмолчанию(ВыбраннаяСтрока, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	НазваниеФормыДляМетрики = Метрика_НазваниеФормы();
	КатегорияМетрики = Метрика_НазваниеКатегории().НастройкиДоверенности;
	ДействиеМетрики = Метрика_НазваниеДействий().НазначитьПоУмолчанию;
	ЛейблМетрики = Метрика_НазваниеДействий().НажатиеКнопки;
	ПредставлениеМетрики = Метрика_НазваниеФормы();
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормыДляМетрики, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	
	Если УстановитьВыбраннойМЧДПризнакПоУмолчаниюНаСервере(ВыбраннаяСтрока.Идентификатор) Тогда
		
		СброситьУДоверенностейПризнакПоУмолчанию();
		
		ВыбраннаяСтрока.ПоУмолчанию 						= Истина;
		ВыбраннаяСтрока.КартинкаДоверенностьПоУмолчанию 	= АдресВХранилищеКартинкиОсновнаяДоверенность;
		
		КонтрактМЧД = КонтрактыМЧД.Получить(ВыбраннаяСтрока.Идентификатор);
		КонтрактМЧД.ПоУмолчанию = Истина;
		
		Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, , , TraceId);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьУДоверенностейПризнакПоУмолчанию()

	Отбор = Новый Структура;
	Отбор.Вставить("ПоУмолчанию", Истина);

	СтрокиСпискаДоверенностей = СписокДоверенностей.НайтиСтроки(Отбор);
	Если СтрокиСпискаДоверенностей.Количество() Тогда
		
		СтрокаСпискаДоверенностей = СтрокиСпискаДоверенностей[0];
		
		СтрокаСпискаДоверенностей.ПоУмолчанию 						= Ложь;
		СтрокаСпискаДоверенностей.КартинкаДоверенностьПоУмолчанию 	= "";
		
		КонтрактМЧД = КонтрактыМЧД.Получить(СтрокаСпискаДоверенностей.Идентификатор);
		КонтрактМЧД.ПоУмолчанию = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция УстановитьВыбраннойМЧДПризнакПоУмолчаниюНаСервере(ИдентификаторМЧД)
	
	Ядро = Модуль_ЯдроНаСервере();
	
	КонтрактМЧД = КонтрактыМЧД.Получить(ИдентификаторМЧД);
	
	Результат = Ядро.МЧД_УстановитьЗначениеПризнакаПоУмолчанию(ИдентификаторЯщика, КонтрактМЧД);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ОбработкаОткрытияДетальнойИнформацииПоДоверенности(ВыбраннаяСтрока, СтандартнаяОбработка)

	КонтрактМЧД = КонтрактыМЧД[ВыбраннаяСтрока.Идентификатор];
	
	ОсновнаяФорма().МЧД_ПоказатьСведенияОДоверенности(КонтрактМЧД, ЭтаФорма);
	
	Метрика_ПоказатьСведенияОДоверенности(ВыбраннаяСтрока.Идентификатор);
	
КонецПроцедуры

&НаКлиенте
Функция СсылкаНаСтраницуЗагрузкиМЧД()
	Возврат "https://diadoc.kontur.ru/BoxId/Preferences";
КонецФункции

&НаКлиенте
Функция СсылкаНаСтраницуВыпускаНовойМЧД()
	Возврат "https://diadoc.kontur.ru";
КонецФункции

&НаКлиенте
Функция СсылкаНаСтраницуИнструкцииПоДобавлениюМЧД()
	Возврат "https://support.kontur.ru/pages/viewpage.action?pageId=83865732";
КонецФункции

&НаКлиенте
Функция Метрика_НазваниеФормы()
	
	Возврат "Форма доверенности";
	
КонецФункции

&НаКлиенте
Функция Метрика_НазваниеКатегории()
	
	Результат = ОсновнаяФорма().Метрика_НазваниеКатегории();

	Возврат Результат;

КонецФункции

&НаКлиенте
Функция Метрика_НазваниеДействий()
	
	Результат = ОсновнаяФорма().Метрика_НазваниеДействий();

	Возврат Результат;

КонецФункции

&НаКлиенте
Функция Метрика_НажатиеКнопки(ДействиеМетрики, ДопПеременные)

	КатегорияМетрики		 = Метрика_НазваниеКатегории().НастройкиДоверенности;
	НазваниеФормыДляМетрики	 = Метрика_НазваниеФормы();
	ПредставлениеМетрики	 = Метрика_НазваниеФормы();
	ЛейблМетрики			 = Метрика_НазваниеДействий().НажатиеКнопки;
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормыДляМетрики, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, , , TraceId);
	
КонецФункции 

&НаКлиенте
Процедура Метрика_ДобавитьДоверенностьНажатие()
	
	КатегорияМетрики		= ОсновнаяФорма().Метрика_НазваниеКатегории().ДобавлениеМЧД;
	ДействиеМетрики			= ОсновнаяФорма().Метрика_НазваниеДействий().ДобавитьМЧД;
	НазваниеФормы			= Метрика_НазваниеФормы();
	ПредставлениеМетрики	= Метрика_НазваниеФормы();
	ЛейблМетрики			= ОсновнаяФорма().Метрика_НазваниеДействий().НажатиеКнопки;
	
	Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики, ЛейблМетрики, ПредставлениеМетрики, TraceId);
	Метрика_ДобавитьСтатистику_ДляОрганизации(ИдентификаторЯщика, КатегорияМетрики, ДействиеМетрики, , , ПредставлениеМетрики, TraceId);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ПоказатьСведенияОДоверенности(ИдентификаторМЧД)
	
	КатегорияМетрики = Метрика_НазваниеКатегории().НастройкиДоверенности;
	ДействиеМетрики	= Метрика_НазваниеДействий().ПосмотретьДоверенность;
	НазваниеФормы = Метрика_НазваниеФормы();
	ПредставлениеМетрики = Метрика_НазваниеФормы();
	
	ДопПеременные = Новый Соответствие;
	ДопПеременные.Вставить("Рег.номер МЧД", ИдентификаторМЧД);
	
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


