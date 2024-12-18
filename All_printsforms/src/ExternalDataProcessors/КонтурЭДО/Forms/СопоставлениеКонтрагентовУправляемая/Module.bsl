
//{ ОписаниеПеременных

&НаСервере
Перем ОбработкаОбъект;

//} ОписаниеПеременных


//{ ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьОбщийКонтекст();
	
	УстановитьОписаниеТиповВсеСправочники();
	
	УстановитьТипЗначенияСправочникаКонтрагенты();
	
	ЗаполнитьТаблицуКонтрагентов();
	
КонецПроцедуры

//} ОбработчикиСобытийФормы


//{ ОбработчикиСобытийТаблицыФормыТаблицаСопоставленияКонтрагентов

&НаКлиенте
Процедура ТаблицаСопоставленияКонтрагентовПередНачаломДобавления(Элемент, Отказ, Копирование)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСопоставленияКонтрагентовПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСопоставленияКонтрагентовКонтрагентОчистка(Элемент, СтандартнаяОбработка)
	
	СброситьОграничениеТиповСвязанногоСправочника();
	
КонецПроцедуры

//} ОбработчикиСобытийТаблицыФормыТаблицаСопоставленияКонтрагентов


//{ ОбработчикиКомандФормы

&НаКлиенте
Процедура Сопоставить(Команда)
	
	Метрики_ЗаписатьНажатие_Сопоставить();
	
	Если ЕстьПустыеСвязи() Тогда
		
		ПоказатьПредупреждениеОПустыхСвязях();
		Возврат;
		
	КонецЕсли;
	
	СохранитьРезультатСопоставления();
	Результат = Истина;
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Отменить(Команда)
	
	Метрики_ЗаписатьНажатие_Отменить();
	
	Результат = Неопределено;
	Закрыть(Результат);
	
КонецПроцедуры

//} ОбработчикиКомандФормы


//{ ОбработчикиОповещений

//} ОбработчикиОповещений


//{ СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьТипЗначенияСправочникаКонтрагенты()
	
	ТипСвязанногоСправочника = ТипСвязанногоСправочникаКонтрагенты();
	УстановитьТипЗначенияСвязанногоСправочника(ТипСвязанногоСправочника);
	
КонецПроцедуры

&НаСервере
Функция ТипСвязанногоСправочникаКонтрагенты()
	
	ИмяСправочника = "Контрагенты";
	
	Ядро = Модуль_ЯдроНаСервере();
	
	ИмяТипа = Ядро.Справочники_ТипЗначенияОбъекта(ИмяСправочника);
	
	Если ЗначениеЗаполнено(ИмяТипа) Тогда
		ТипЗначения = Тип(ИмяТипа);
	Иначе
		ТипЗначения = ОписаниеТиповВсехСсылок;
	КонецЕсли;
	
	Возврат ТипЗначения;
	
КонецФункции

&НаСервере
Процедура УстановитьТипЗначенияСвязанногоСправочника(УстанавливаемыйТип)
	
	Если УстанавливаемыйТип = Неопределено Тогда
		
		ОписаниеТипов = ОписаниеТиповВсехСсылок;
		
	ИначеЕсли ТипЗнч(УстанавливаемыйТип) = Тип("ОписаниеТипов") Тогда
		
		ОписаниеТипов = УстанавливаемыйТип;
		
	Иначе
		
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(УстанавливаемыйТип);
		ОписаниеТипов = Новый ОписаниеТипов(МассивТипов);
		
	КонецЕсли;
	
	ПолеКонтрагент = Элементы.ТаблицаСопоставленияКонтрагентовКонтрагент;
	
	ПолеКонтрагент.ОграничениеТипа = ОписаниеТипов;
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьОграничениеТиповСвязанногоСправочника()
	
	ПолеКонтрагент = Элементы.ТаблицаСопоставленияКонтрагентовКонтрагент;
	ПолеКонтрагент.ОграничениеТипа = ОписаниеТиповВсехСсылок;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОписаниеТиповВсеСправочники()
	
	ОписаниеТиповВсехСсылок = Справочники.ТипВсеСсылки();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуКонтрагентов()
	
	АдресТаблицыСопоставленияКонтрагентов = Параметры.АдресТаблицыСопоставленияКонтрагентов;
	ТаблицаСопоставления = ПолучитьИзВременногоХранилища(АдресТаблицыСопоставленияКонтрагентов);
	
	ТаблицаСопоставленияКонтрагентов.Загрузить(ТаблицаСопоставления);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьРезультатСопоставления()
	
	СоздатьНовыеСвязи();
	
	ТаблицаСопоставления = РеквизитФормыВЗначение("ТаблицаСопоставленияКонтрагентов");
	ПоместитьВоВременноеХранилище(ТаблицаСопоставления, АдресТаблицыСопоставленияКонтрагентов);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ВидОперацииСопоставлениеКонтрагентов()
	
	Результат = "Сопоставление контрагентов";
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура УстановитьСвязь(ИдентификаторКонтрагента, КонтрагентИБ)
	
	СвязанныеСправочники = Новый Массив;
	СвязанныеСправочники.Добавить(КонтрагентИБ);
	
	ОбновляемыеПараметры = Новый Структура;
	ОбновляемыеПараметры.Вставить("СвязанныеСправочники", СвязанныеСправочники);
	
	Ядро = Модуль_ЯдроНаСервере();
	
	Попытка
		
		Ядро.Контрагенты_ОбновлениеРеквизитов(ИдентификаторКонтрагента, ОбновляемыеПараметры);
		
	Исключение
		
		Ошибка = ИнформацияОбОшибке();
		
		Ядро.Ошибка_Обработать(
			ВидОперацииСопоставлениеКонтрагентов(),
			ПодробноеПредставлениеОшибки(Ошибка),
		);
		
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьНовыеСвязи()
	
	Для Каждого Запись Из ТаблицаСопоставленияКонтрагентов Цикл
		
		КонтрагентИБ = Запись.Контрагент;
		Если ЗначениеЗаполнено(КонтрагентИБ)
			И Не Запись.Сопоставлено Тогда
			
			ИдентификаторКонтрагента = Запись.КонтрагентСервисаИдентификатор;
			УстановитьСвязь(ИдентификаторКонтрагента, КонтрагентИБ);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьПредупреждениеОПустыхСвязях()
	
	ОбработчикОповещения = Неопределено;
	
	ЗаголовокСообщения = НСтр("ru = 'Сопоставление контрагентов'; en = 'Сопоставление контрагентов'");
	
	ТекстСообщения = НСтр(
		"ru = 'Есть несопоставленные контрагенты. Проверьте и сопоставьте.';
		|en = 'Есть несопоставленные контрагенты. Проверьте и сопоставьте.'"
	);
	
	Таймаут = 60;
	
	ГлавнаяФорма = ОсновнаяФорма();
	ГлавнаяФорма.ПоказатьПредупреждениеПереопределенная(
		ОбработчикОповещения,
		ТекстСообщения,
		Таймаут,
		ЗаголовокСообщения
	);
	
КонецПроцедуры

&НаКлиенте
Функция ЕстьПустыеСвязи()
	
	Результат = Ложь;
	
	Для Каждого Запись Из ТаблицаСопоставленияКонтрагентов Цикл
		
		Если Не ЗначениеЗаполнено(Запись.Контрагент) Тогда
			Результат = Истина;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

//} СлужебныеПроцедурыИФункции


//{ СервисныеМетоды

&НаСервере
Процедура УстановитьОбщийКонтекст()
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
КонецПроцедуры

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
Функция ОсновнаяФорма()
	
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

//} СервисныеМетоды

//{ Метрики

// Записывает поведение и статистику о нажатии кнопки "Сопоставить".
//
&НаКлиенте
Процедура Метрики_ЗаписатьНажатие_Сопоставить()
	
	Действие = Метрики_ДействиеСопоставить();
	
	Метрики_НажатиеКнопки(Действие);
	Метрики_ДобавитьСтатистикуПоКонтексту(Действие);
	
КонецПроцедуры

// Записывает поведение и статистику о нажатии кнопки "Отменить".
//
&НаКлиенте
Процедура Метрики_ЗаписатьНажатие_Отменить()
	
	Действие = Метрики_ДействиеОтменить();
	
	Метрики_НажатиеКнопки(Действие);
	Метрики_ДобавитьСтатистикуПоКонтексту(Действие);
	
КонецПроцедуры

// Добавляет запись в топик "Статистика" (DD_Statistics) по всем организациям (контекста).
//
// Параметры:
//  ДействиеМетрики - Строка - значение "Path_Action".
//
&НаКлиенте
Процедура Метрики_ДобавитьСтатистикуПоКонтексту(ДействиеМетрики)
	
	КатегорияМетрики 	= Метрики_КатегорияСопоставлениеКонтрагентов();
	МеткаМетрики 		= "";
	Переменные 			= Новый Соответствие;
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Метрика_ДобавитьСтатистику_ПоКонтексту(
			КатегорияМетрики,
			ДействиеМетрики,
			МеткаМетрики,
			Переменные
		);
	
КонецПроцедуры

// Добавляет запись в топик "Поведение" (DD_Behavior).
//
// Параметры:
//  ДействиеМетрики - Строка - значение "Path_Action".
//
&НаКлиенте
Процедура Метрики_НажатиеКнопки(ДействиеМетрики)
	
	НазваниеФормы = Метрики_НазваниеФормы();
	КатегорияМетрики = Метрики_КатегорияСопоставлениеКонтрагентов();
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(
		НазваниеФормы,
		КатегорияМетрики,
		ДействиеМетрики
	);
	
КонецПроцедуры

&НаКлиенте
Функция Метрики_НазваниеФормы()
	Возврат "Сопоставление контрагентов";
КонецФункции

&НаКлиенте
Функция Метрики_ДействиеСопоставить()
	Возврат "Сопоставить";
КонецФункции

&НаКлиенте
Функция Метрики_ДействиеОтменить()
	Возврат "Отменить";
КонецФункции

&НаКлиенте
Функция Метрики_КатегорияСопоставлениеКонтрагентов()
	
	Ядро = Модуль_ЯдроНаКлиенте();
	Категории = Ядро.Метрика_НазваниеКатегории();
	Результат = Категории.СопоставлениеКонтрагентовПриУчете;
	
	Возврат Результат;
	
КонецФункции

//} Метрики
