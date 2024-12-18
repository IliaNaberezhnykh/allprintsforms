
&НаСервере
Перем ОбработкаОбъект;

//{		Сервисные методы
	
&НаСервере
Функция ОбработкаОбъект()

	Результат = РеквизитФормыВЗначение("Объект");
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция Модуль_Ядро()
 	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Модуль_ЯдроНаКлиенте()
	
	Результат = ОсновнаяФорма().Модуль_ЯдроНаКлиенте();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Модуль_СинхронноМодальныеВызовы()
	
	Результат = ПолучитьФорму(ПутьКФормам + "Модуль_СинхронныеМодальныеВызовы", , ЭтаФорма);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма() Экспорт
	
	Результат = ВладелецФормы.ОсновнаяФорма();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция МетодСервераБезКонтекста(ВозвращатьРезультат, ИмяМетода, Параметр0 = Неопределено, Параметр1 = Неопределено,
								 Параметр2 = Неопределено, Параметр3 = Неопределено, Параметр4 = Неопределено) Экспорт
		
	Возврат МетодСервера(ВозвращатьРезультат, ИмяМетода, Параметр0, Параметр1, Параметр2, Параметр3, Параметр4);
	
КонецФункции

&НаСервере
Функция МетодСервера(Знач ВозвращатьРезультат, Знач ИмяМетода, Параметр0 = Неопределено, Параметр1 = Неопределено,
					 Параметр2 = Неопределено, Параметр3 = Неопределено, Параметр4 = Неопределено)
		
	СтрокаПараметров = ПараметрыСтрокой(Параметр0, Параметр1, Параметр2, Параметр3, Параметр4);
	
	Если ВозвращатьРезультат Тогда
		Возврат Вычислить(ИмяМетода + "(" + СтрокаПараметров + ")");
	Иначе
		Выполнить(ИмяМетода + "(" + СтрокаПараметров + ")");
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ПараметрыСтрокой(Параметр0 = Неопределено,
						 Параметр1 = Неопределено,
						 Параметр2 = Неопределено,
						 Параметр3 = Неопределено,
						 Параметр4 = Неопределено)
		
	Разделитель= 			"";
	ПараметрыСтрокой= 		"";
	ДобавитьПустойПараметр= Ложь;
	
	Если Не Параметр4 = Неопределено Тогда
		ПараметрыСтрокой= "Параметр4"+Разделитель+ПараметрыСтрокой;
		Разделитель= ", ";
		ДобавитьПустойПараметр= Истина;
		ИндексПоследнегоПараметра= 4;
	Иначе
		Если ДобавитьПустойПараметр Тогда
			ПараметрыСтрокой= Разделитель+ПараметрыСтрокой;
			Разделитель= ",";
		Иначе
			Разделитель= "";
		КонецЕсли;
	КонецЕсли;
	
	Если Не Параметр3 = Неопределено Тогда
		ПараметрыСтрокой= "Параметр3"+Разделитель+ПараметрыСтрокой;
		Разделитель= ", ";
		ДобавитьПустойПараметр= Истина;
	Иначе
		Если ДобавитьПустойПараметр Тогда
			ПараметрыСтрокой= Разделитель+ПараметрыСтрокой;
			Разделитель= ",";
		Иначе
			Разделитель= "";
		КонецЕсли;
	КонецЕсли;
	
	Если Не Параметр2 = Неопределено Тогда
		ПараметрыСтрокой= "Параметр2"+Разделитель+ПараметрыСтрокой;
		Разделитель= ", ";
		ДобавитьПустойПараметр= Истина;
	Иначе
		Если ДобавитьПустойПараметр Тогда
			ПараметрыСтрокой= Разделитель+ПараметрыСтрокой;
			Разделитель= ",";
		Иначе
			Разделитель= "";
		КонецЕсли;
	КонецЕсли;
	
	Если Не Параметр1 = Неопределено Тогда
		ПараметрыСтрокой= "Параметр1"+Разделитель+ПараметрыСтрокой;
		Разделитель= ", ";
		ДобавитьПустойПараметр= Истина;
	Иначе
		Если ДобавитьПустойПараметр Тогда
			ПараметрыСтрокой= Разделитель+ПараметрыСтрокой;
			Разделитель= ",";
		Иначе
			Разделитель= "";
		КонецЕсли;
	КонецЕсли;
	
	Если Не Параметр0 = Неопределено Тогда
		ПараметрыСтрокой= "Параметр0"+Разделитель+ПараметрыСтрокой;
	ИначеЕсли ДобавитьПустойПараметр Тогда
		ПараметрыСтрокой= Разделитель+ПараметрыСтрокой;
	КонецЕсли;
	
	Возврат ПараметрыСтрокой;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуПереопределенная(ИмяФормы,
		ПараметрыФормы = Неопределено,
		Владелец = Неопределено,
		Уникальность = Ложь,
		Окно = Неопределено,
		НавигационнаяСсылка = Неопределено,
		ОписаниеОповещенияОЗакрытии = Неопределено,
		РежимОткрытияОкна = Неопределено)
	
	Модуль_СинхронноМодальныеВызовы = Модуль_СинхронноМодальныеВызовы();
	Модуль_СинхронноМодальныеВызовы.смв_ОткрытьФорму(ИмяФормы,
		ПараметрыФормы,
		Владелец,
		Уникальность,
		Окно,
		НавигационнаяСсылка,
		ОписаниеОповещенияОЗакрытии,
		РежимОткрытияОкна);
	
КонецПроцедуры

//}		Сервисные методы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ПутьКФормам = ОбработкаОбъект.Метаданные().ПолноеИмя() + ".Форма.";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииРаботыМодуля(Знач ПродуктоваяАналитика) Экспорт
	
	ПриЗавершенииРаботыМодуляВызовСервера(ПродуктоваяАналитика);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗавершенииРаботыМодуляВызовСервера(Знач ПродуктоваяАналитика)
	
	Модуль = РеквизитФормыВЗначение("Объект");
	Модуль.ПроверитьЗависимости();
	
	Ядро = Модуль_Ядро();
	
	Ядро.ПродуктоваяАналитика_ОтправитьДанныеБезопасно(ПродуктоваяАналитика);
	
	Ядро.Метрика_ДобавитьСтатистику_ИспользованиеПМ();
	
	_ИмяФормы = "Основная форма";
	_Действие = "Инициализация модуля";
	_Открытие = Ложь;
	Ядро.Метрика_ДобавитьПоведение_ДействиеСФормой(
		_ИмяФормы,
		_Действие,
		_Открытие
	);
	
	Ядро.ЗавершитьРаботуЯдра();
	
	Модуль.ЗавершитьРаботуМодуля();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНовуюВерсиюМодуля() Экспорт
	
	УстановитьНовуюВерсиюМодуляВызовСервера();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНовуюВерсиюМодуляВызовСервера()
	
	Модуль = ОбработкаОбъект();
	Модуль.УстановитьНовуюВерсиюМодуля();
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьОбновитьТипыДокументов(СохраненнаяВерсияПриЗапуске) Экспорт
	
	ПроверитьОбновитьТипыДокументовВызовСервера(СохраненнаяВерсияПриЗапуске);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьОбновитьТипыДокументовВызовСервера(СохраненнаяВерсияПриЗапуске)
	
	Модуль = ОбработкаОбъект();
	Модуль.ПроверитьОбновитьТипыДокументов(СохраненнаяВерсияПриЗапуске);
	
КонецПроцедуры

// Сохраняет значения настроек периода отбора документов для текущего пользователя.
//
// Параметры:
//  Интервал - ВариантСтандартногоПериода - Идентификатор периода отбора документов.
//  РежимОтбора - Строка - Идентификатор режима отбора документов по дате документа или дате получения.
//
&НаКлиенте
Процедура ПользовательскиеНастройкиПериодаУстановить(Интервал, РежимОтбора) Экспорт
	
	ПользовательскиеНастройкиПериодаУстановитьВызовСервера(Интервал, РежимОтбора);
	
КонецПроцедуры

&НаСервере
Процедура ПользовательскиеНастройкиПериодаУстановитьВызовСервера(Интервал, РежимОтбора)
	
	Модуль = ОбработкаОбъект();
	Модуль.ПользовательскиеНастройкиПериодаУстановить(Интервал, РежимОтбора);
	
КонецПроцедуры


&НаКлиенте
Процедура ПоказатьПредупреждениеОТарифе(НаименованиеФормы) Экспорт
	
	ОсновнаяФорма = ОсновнаяФорма();
	
	ЗаголовокСообщения = "";
	
	ТекстСообщения = НСтр(
			"ru = 'Некоторые возможности недоступны для тарифа ""Стартовый"". 
			|Перейдите на тариф ""Универсальный"" и получите доступ к расширенной функциональности модуля Диадок.'");
	
	КнопкаПоУмолчанию = КодВозвратаДиалога.Отмена;
	
	СписокКнопок = Новый СписокЗначений;
	СписокКнопок.Добавить(КодВозвратаДиалога.ОК, "Узнать подробнее");
	СписокКнопок.Добавить(КнопкаПоУмолчанию, "Закрыть");
	
	ИмяОбработчикаПослеВызоваВопроса = "ПослеВызоваПредупрежденияОТарифе";
	Таймаут = 0;
	
	ОповещениеОЗавершении = ОсновнаяФорма.НовыйОписаниеОповещения(
			ИмяОбработчикаПослеВызоваВопроса,
			ЭтаФорма,
			НаименованиеФормы);
	
	ОсновнаяФорма.ПоказатьВопросПереопределенная(
		ОповещениеОЗавершении,
		ТекстСообщения,
		СписокКнопок,
		Таймаут,
		КнопкаПоУмолчанию,
		ЗаголовокСообщения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВызоваПредупрежденияОТарифе(Результат, НаименованиеФормы) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		АдресСсылки = "https://promo.diadoc.ru/tariff-universal";
		
		ПерейтиПоНавигационнойСсылке(АдресСсылки);
		
		Метрика_УзнатьПодробнееОТарифе(НаименованиеФормы);
		
	КонецЕсли;
	
КонецПроцедуры

// Открывает список контрагентов в режиме выбора значения
//
// Параметры:
//  Организация - Строка - Идентификатор организации (BoxId)
//  ПараметрВладелец - ФормаКлиентскогоПриложения - (Необязательный) форма-владелец
//  ОбработчикЗакрытия - ОписаниеОповещения - (Необязательный) описание оповещения о закрытии формы
//
&НаКлиенте
Процедура Контрагенты_ВыбратьКонтрагента(Организация = Неопределено, Знач ПараметрВладелец = Неопределено, ОбработчикЗакрытия = Неопределено) Экспорт
	
	РежимСпискаКА = "ВашиКонтрагенты";
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОтборПоОрганизации", Организация);
	ПараметрыФормы.Вставить("ТекущийРежимСписка", РежимСпискаКА);
	ПараметрыФормы.Вставить("РежимВыбораИзСписка", Истина);
	ПараметрыФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормы.Вставить("Объект", Объект);
	
	КлючУникальностиФормы = РежимСпискаКА;
	ИмяФормыСпискаКА = ПутьКФормам + "Контрагенты_ФормаСпискаV2Управляемая";
	
	Если ПараметрВладелец = Неопределено Тогда
		ПараметрВладелец = ОсновнаяФорма();
	КонецЕсли;
	
	ОткрытьФормуПереопределенная(
		ИмяФормыСпискаКА,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		Неопределено,
		Неопределено,
		ОбработчикЗакрытия
	);
	
КонецПроцедуры

// Открывает список контрагентов
//
// Параметры:
//  Организация - Строка - (Необязательный) Идентификатор организации (BoxId)
//  ОбработчикЗакрытия - ОписаниеОповещения - (Необязательный) обработчик оповещения о закрытии списка контрагентов
//  СтрокаПоиска - Строка - (Необязательный) при открытии списка контрагентов будет произведен поиск по указанному значению
//
&НаКлиенте
Процедура Контрагенты_ПоказатьСписокКонтрагентов(Организация = Неопределено, ОбработчикЗакрытия = Неопределено, СтрокаПоиска = Неопределено) Экспорт
	
	РежимСпискаКА = "ВашиКонтрагенты";
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОтборПоОрганизации", Организация);
	ПараметрыФормы.Вставить("ТекущийРежимСписка", РежимСпискаКА);
	ПараметрыФормы.Вставить("РежимВыбораИзСписка", Ложь);
	ПараметрыФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормы.Вставить("Объект", Объект);
	ПараметрыФормы.Вставить("СтрокаПоиска", СтрокаПоиска);
	
	КлючУникальностиФормы = РежимСпискаКА;
	ИмяФормыСпискаКА = ПутьКФормам + "Контрагенты_ФормаСпискаV2Управляемая";
	
	ПараметрВладелец = ОсновнаяФорма();
	
	ОткрытьФормуПереопределенная(
		ИмяФормыСпискаКА,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		Неопределено,
		Неопределено,
		ОбработчикЗакрытия
	);
	
КонецПроцедуры

// Открывает форму поиска и приглашения контрагентов
//
// Параметры:
//  Организация - Строка - (Необязательный) Идентификатор организации (BoxId)
//  ОбработчикЗакрытия - ОписаниеОповещения - (Необязательный) обработчик оповещения о закрытии списка контрагентов
//  СтрокаПоиска - Строка - (Необязательный) при открытии списка контрагентов будет произведен поиск по указанному значению
//
&НаКлиенте
Процедура Контрагенты_ПоказатьФормуПоискаИПриглашения(Организация = Неопределено, ОбработчикЗакрытия = Неопределено, СтрокаПоиска = Неопределено) Экспорт
	
	РежимСпискаКА = "ПоискИПриглашение";
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОтборПоОрганизации", Организация);
	ПараметрыФормы.Вставить("ТекущийРежимСписка", РежимСпискаКА);
	ПараметрыФормы.Вставить("РежимВыбораИзСписка", Ложь);
	ПараметрыФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормы.Вставить("Объект", Объект);
	ПараметрыФормы.Вставить("СтрокаПоиска", СтрокаПоиска);
	
	КлючУникальностиФормы = РежимСпискаКА;
	ИмяФормыСпискаКА = ПутьКФормам + "Контрагенты_ФормаСпискаV2Управляемая";
	
	ПараметрВладелец = ОсновнаяФорма();
	
	ОткрытьФормуПереопределенная(
		ИмяФормыСпискаКА,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		Неопределено,
		Неопределено,
		ОбработчикЗакрытия
	);
	
КонецПроцедуры

// Проверяет, оценивал ли пользователь работу с указанной функциональностью модуля
// 
// Параметры:
//  ФункциональностьМодуля - Строка - см. Ядро.Перечисление_СценарииМодуляДляОтзывов()
//
// Возвращаемое значение:
//  Булево - Истина, если оценка уже есть
//
&НаКлиенте
Функция ОтзывПоРаботеСМодулем_ТребуетсяОценка(СценарийМодуляДляОтзыва) Экспорт
	
	Результат = ОтзывПоРаботеСМодулем_ТребуетсяОценкаВызовСервера(СценарийМодуляДляОтзыва);
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ОтзывПоРаботеСМодулем_ТребуетсяОценкаВызовСервера(СценарийМодуляДляОтзыва)
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	Результат = МодульОбъекта.ОтзывПоРаботеСМодулем_ТребуетсяОценка(СценарийМодуляДляОтзыва);
	
	Возврат Результат;
	
КонецФункции

// Открывает форму предупреждения
//
// Параметры:
//  ТекстПредупреждения - Строка - Текст предупреждения пользователя
//  Комментарий - Строка - Дополнительный комментарий
//  Заголовок - Строка - Заголовок формы предупреждения
//  ОбработчикЗакрытия - ОписаниеОповещения - обработчик оповещения о закрытии
//
&НаКлиенте
Процедура ОткрытьФормуПредупреждения(ТекстПредупреждения, Комментарий = Неопределено, Заголовок = Неопределено, ОбработчикЗакрытия = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТекстПредупреждения", ТекстПредупреждения);
	ПараметрыФормы.Вставить("Комментарий", Комментарий);
	ПараметрыФормы.Вставить("Заголовок", Заголовок);
	ПараметрыФормы.Вставить("Объект", Объект);
	
	ИмяФормыПредупреждения = ПутьКФормам + "ФормаПредупрежденияУправляемая";
	
	ПараметрВладелец = ОсновнаяФорма();
	
	ОткрытьФормуПереопределенная(
		ИмяФормыПредупреждения,
		ПараметрыФормы,
		ПараметрВладелец,
		Неопределено,
		Неопределено,
		Неопределено,
		ОбработчикЗакрытия,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца
	);
	
КонецПроцедуры

&НаКлиенте
Функция ВыгрузитьВложенныеОбработки() Экспорт
	
	Результат = ВыгрузитьВложенныеОбработкиВызовСервера();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ВыгрузитьВложенныеОбработкиВызовСервера()
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	
	Результат = МодульОбъекта.ВыгрузитьВложенныеОбработки();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПроверитьВозможностьПодключения(ИмяМодуля) Экспорт
	
	Результат = ПроверитьВозможностьПодключенияВызовСервера(ИмяМодуля);
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ПроверитьВозможностьПодключенияВызовСервера(ИмяМодуля)
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	
	Результат = МодульОбъекта.ПроверитьВозможностьПодключения(ИмяМодуля);
	
	Возврат Результат;
	
КонецФункции

// Открывает форму мастера первого запуска в режиме конфигурирования модуля
//
// Параметры:
//
//  ТипАвторизации - Строка - (Необязательный) Возможные значения: "Сертификат", "Логин", пустая строка
//  ОбработчикЗакрытия - Структура, ОписаниеОповещения - (Необязательный) оповещение о закрытии формы мастера первого запуска
//
&НаКлиенте
Процедура ПоказатьМастерПервогоЗапуска(ТипАвторизации, ОбработчикЗакрытия = Неопределено) Экспорт
	
	ПараметрыФормы = НастройкиМастераПервогоЗапуска();
	ПараметрыФормы.ПоказатьШагНастройкиОтправкиДокументов = Истина;
	ПараметрыФормы.ПоказатьНачальнуюСтраницу = Истина;
	ПараметрыФормы.ТипАвторизации = ТипАвторизации;
	
	ОткрытьМастерПервогоЗапуска(ПараметрыФормы, ОбработчикЗакрытия);
	
КонецПроцедуры

// Открывает форму мастера первого запуска в режиме настройк организации
//
&НаКлиенте
Процедура ЗапуститьНастройкуОрганизации(ОбработчикЗакрытия = Неопределено) Экспорт
	
	ПараметрыФормы = НастройкиМастераПервогоЗапуска();
	
	ОткрытьМастерПервогоЗапуска(ПараметрыФормы, ОбработчикЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьМастерПервогоЗапуска(ПараметрыФормы, ОбработчикЗакрытия = Неопределено)
	
	ИмяФормыМастераПервогоЗапуска = ПутьКФормам + "МастерПервогоЗапускаУправляемая";
	ПараметрВладелец = ОсновнаяФорма();
	КлючУникальностиФормы = "МастерПервогоЗапуска";
	
	ОткрытьФормуПереопределенная(
		ИмяФормыМастераПервогоЗапуска,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		Неопределено,
		Неопределено,
		ОбработчикЗакрытия,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца
	);
	
КонецПроцедуры

&НаКлиенте
Функция НастройкиМастераПервогоЗапуска()
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ПоказатьШагНастройкиОтправкиДокументов", Ложь);
	ПараметрыФормы.Вставить("ПоказатьНачальнуюСтраницу", Ложь);
	ПараметрыФормы.Вставить("ТипАвторизации", "");
	ПараметрыФормы.Вставить("РежимВыбораИзСписка", Ложь);
	ПараметрыФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормы.Вставить("Объект", Объект);
	
	Возврат ПараметрыФормы;
	
КонецФункции

// Открывает форму помощника поиска документа в модуле
//
// Параметры:
//
//  ОбработчикЗакрытия - Структура, ОписаниеОповещения - (Необязательный) оповещение о закрытии формы мастера первого запуска
//
&НаКлиенте
Процедура ПоказатьПомощникПоискаДокумента(ОбработчикЗакрытия = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбораИзСписка", Ложь);
	ПараметрыФормы.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормы.Вставить("Объект", Объект);
	
	ИмяФормыПомощникаПоискаДокумента = ПутьКФормам + "ПомощникПоискаДокументаУправляемая";
	ПараметрВладелец = ОсновнаяФорма();
	КлючУникальностиФормы = "ПомощникПоискаДокументаУправляемая";
	ОкноПриложения = Неопределено;
	НавигационнаяСсылка = Неопределено;
	
	ОткрытьФормуПереопределенная(
		ИмяФормыПомощникаПоискаДокумента,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		ОкноПриложения,
		НавигационнаяСсылка,
		ОбработчикЗакрытия,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца
	);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьФормуСопоставленияКонтрагента(КонтрагентИБ, ОрганизацияИБ = Неопределено, ОбработчикЗакрытия = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("КонтрагентИБ", КонтрагентИБ);
	ПараметрыФормы.Вставить("ОрганизацияИБ", ОрганизацияИБ);
	ПараметрыФормы.Вставить("Объект", Объект);
	
	ИмяФормыПомощникаПоискаДокумента = ПутьКФормам + "Контрагенты_ФормаСопоставленияУправляемая";
	ПараметрВладелец = ОсновнаяФорма();
	КлючУникальностиФормы = "Контрагенты_ФормаСопоставленияУправляемая";
	ОкноПриложения = Неопределено;
	НавигационнаяСсылка = Неопределено;
	
	ОткрытьФормуПереопределенная(
		ИмяФормыПомощникаПоискаДокумента,
		ПараметрыФормы,
		ПараметрВладелец,
		КлючУникальностиФормы,
		ОкноПриложения,
		НавигационнаяСсылка,
		ОбработчикЗакрытия,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца
	);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключаемыйМодуль_НачатьВыборФайла(ОписаниеОповещения) Экспорт
	
	Режим = РежимДиалогаВыбораФайла.Открытие;
	
	ПараметрыВыбора = Новый Структура;
	ПараметрыВыбора.Вставить("Фильтр", "Внешняя обработка 1С:Предприятия 8 (*.epf)|*.epf");
	ПараметрыВыбора.Вставить("Заголовок", "Выберите файл подключаемого модуля");
	ПараметрыВыбора.Вставить("МножественныйВыбор", Ложь);
	
	ГлавнаяФорма = ОсновнаяФорма();
	ГлавнаяФорма.ПоказатьДиалогВыбораФайла(ОписаниеОповещения, Режим, ПараметрыВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключаемыйМодуль_НачатьВыборВстроеннойОбработки(ОписаниеОповещения, ТекущееЗначение = Неопределено) Экспорт
	
	Список = ВстроенныеОбработки();
	
	ГлавнаяФорма = ОсновнаяФорма();
	ГлавнаяФорма.ПоказатьВыборЭлемента(
		Список,
		ОписаниеОповещения,
		"Выберите встроенную обработку",
		ТекущееЗначение
	);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВстроенныеОбработки()
	
	Список = Новый СписокЗначений;
	
	Для Каждого Обработка Из Метаданные.Обработки Цикл
		Список.Добавить(Обработка.Имя);
	КонецЦикла;
	
	Возврат Список;
	
КонецФункции

&НаКлиенте
Процедура Метрика_УзнатьПодробнееОТарифе(НаименованиеФормы)
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	
	КатегорияМетрики = Метрика_НастройкаНедоступна();
	ДействиеМетрики = Метрика_УзнатьПодробнее();
	
	Модуль_Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(
		НаименованиеФормы, 
		КатегорияМетрики, 
		ДействиеМетрики);
		
	Модуль_Ядро.Метрика_ДобавитьСтатистику_ПоКонтексту(
		КатегорияМетрики, 
		ДействиеМетрики);

КонецПроцедуры

&НаКлиенте
Функция Метрика_УзнатьПодробнее()
	
	Возврат "УзнатьПодробнее";

КонецФункции

&НаКлиенте
Функция Метрика_НастройкаНедоступна()
	
	Возврат "НастройкаНедоступна";

КонецФункции

&НаКлиенте
Функция ЦП_НовыйПараметрыОткрытияСессии(BoxId, РежимОткрытияЦП = Неопределено) Экспорт
	
	Результат = ЦП_НовыйПараметрыОткрытияСессииВызовСервера(BoxId, РежимОткрытияЦП);
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ЦП_НовыйПараметрыОткрытияСессииВызовСервера(BoxId, РежимОткрытияЦП) Экспорт
	
	ОбработкаОбъект = ОбработкаОбъект();
	
	Результат = ОбработкаОбъект.ЦП_НовыйПараметрыОткрытияСессии(BoxId, РежимОткрытияЦП);
	
	Возврат Результат;
	
КонецФункции

// Загружает настройку "Поздравление_ПоказатьНовомуПользователюПриЗапуске"
// из хранилища общих настроек текущего пользователя
//
// Возвращаемое значение:
//   Булево - Истина, если требуется открыть форму поздравления текущему пользователю
//
&НаКлиенте
Функция Поздравление_ПоказыватьПриЗапуске() Экспорт
	
	Результат = Поздравление_ПоказыватьПриЗапускеВызовСервера();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция Поздравление_ПоказыватьПриЗапускеВызовСервера()
	
	КлючНастройки = "Поздравление_ПоказатьНовомуПользователюПриЗапуске";
	ЗначениеПоУмолчанию = Истина;
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	Результат = МодульОбъекта.ХранилищеОбщихНастроек_Загрузить(КлючНастройки, ЗначениеПоУмолчанию);
	
	Возврат Результат;
	
КонецФункции

// Сохраняет настройку "Поздравление_ПоказатьНовомуПользователюПриЗапуске"
// в хранилище общих настроек текущего пользователя
//
&НаКлиенте
Процедура Поздравление_Отключить() Экспорт
	
	Поздравление_ОтключитьВызовСервера();
	
КонецПроцедуры

&НаСервере
Процедура Поздравление_ОтключитьВызовСервера()
	
	КлючНастройки = "Поздравление_ПоказатьНовомуПользователюПриЗапуске";
	Значение = Ложь;
	
	МодульОбъекта = РеквизитФормыВЗначение("Объект");
	МодульОбъекта.ХранилищеОбщихНастроек_Сохранить(КлючНастройки, Значение);
	
КонецПроцедуры
