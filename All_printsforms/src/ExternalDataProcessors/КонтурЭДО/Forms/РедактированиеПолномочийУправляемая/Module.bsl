
&НаСервере
Перем мОбработкаОбъект;

//{ Сервисные методы

&НаСервере
Функция ОбработкаОбъект()
	
	Если мОбработкаОбъект = Неопределено Тогда
		мОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	КонецЕсли;
	
	Возврат мОбработкаОбъект;
	
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

&НаКлиенте
Функция ОсновнаяФорма() Экспорт
	
	Результат = ВладелецФормы.ОсновнаяФорма();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ИнициализироватьФорму(ПараметрыФормы) 
	
	АдресЯщика			= ПараметрыФормы.АдресЯщика;
	ТипКонтента			= ПараметрыФормы.ТипКонтента;
	ПокупательПродавец	= ПараметрыФормы.ПокупательПродавец;
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ПредставлениеПодписанта	= Модуль_Ядро.Подписант_ПредставлениеПодписанта(АдресЯщика);
	ТипыКонтента = Модуль_Ядро.Перечисление_ТипыКонтентов();
	
	Если ТипКонтента = ТипыКонтента.utd970 Тогда
		УПД970_ЗаполнитьФормуПолномочиямиПодписанта();
	Иначе
		ЗаполнитьФормуПолномочиямиПодписанта();
		ЗаполнитьСписокВыбора_ОбластьПолномочий();
		ЗаполнитьСписокВыбора_СтатусРаботника();
	КонецЕсли;
	
	ЗаполнитьОрганизациюПодписанта();
	ЗаполнитьЗаголовокФормы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьФормуПолномочиямиПодписанта()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ПолномочияПодписанта = ПолучитьПолномочияПодписанта();
	
	Если ПолномочияПодписанта <> Неопределено Тогда
		
		ОбластьПолномочий 	= ПолномочияПодписанта.SignerPowers;
		СтатусРаботника		= ПолномочияПодписанта.SignerStatus;
		ОснованияПолномочий	= Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "SignerPowersBase", "");
		
		Должность	 = Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "JobTitle",	"");
		ИныеСведения = Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "SignerInfo",	"");
		
		ОснованияПолномочийОрганизации	= Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "SignerOrgPowersBase",	"");
		СвидетельствоОРегистрацииИП		= Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "RegistrationCertificate","");
		
	КонецЕсли;
	
	ПодписантСотрудникОрганизации = Модуль_Ядро.Подписант_ЭтоСотрудникОрганизации(АдресЯщика);
	
	Если ЗначениеЗаполнено(СвидетельствоОРегистрацииИП) Тогда
		Элементы.ГруппаСвидетельствоОРегистрацииИП_Значение.ТекущаяСтраница = Элементы.СтраницаСвидетельствоОРегистрацииИП_Значение;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИныеСведения) Тогда
		Элементы.ГруппаИныеСведенияЗначение.ТекущаяСтраница = Элементы.СтраницаИныеСведенияЗначение;
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Процедура УПД970_ЗаполнитьФормуПолномочиямиПодписанта()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ПолномочияПодписанта = ПолучитьПолномочияПодписанта();
	
	Если ПолномочияПодписанта <> Неопределено Тогда
		
		Должность	 = Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "JobTitle",	"");
		ИныеСведения = Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "SignerInfo",	"");
		
		СвидетельствоОРегистрацииИП = Модуль_Ядро.СвойствоСтруктуры(ПолномочияПодписанта, "RegistrationCertificate","");
		
	КонецЕсли;
	
	ПодписантСотрудникОрганизации = Модуль_Ядро.Подписант_ЭтоСотрудникОрганизации(АдресЯщика);
	
	Если ЗначениеЗаполнено(СвидетельствоОРегистрацииИП) Тогда
		Элементы.ГруппаСвидетельствоОРегистрацииИП_Значение.ТекущаяСтраница = Элементы.СтраницаСвидетельствоОРегистрацииИП_Значение;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИныеСведения) Тогда
		Элементы.ГруппаИныеСведенияЗначение.ТекущаяСтраница = Элементы.СтраницаИныеСведенияЗначение;
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Функция ПолучитьПолномочияПодписанта()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ВидТитула = Модуль_Ядро.Документы_ВидТитула(ТипКонтента);
	ОписаниеПолномочийПодписанта = Модуль_Ядро.ПолномочияПодписанта_Получить(АдресЯщика, ВидТитула, ПокупательПродавец);
	Результат = ОписаниеПолномочийПодписанта.Данные;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьОрганизациюПодписанта()
	
	СтрокаКонтекста	= Модуль_ЯдроНаСервере().КонтекстСеанса_СтрокаКонтекста(АдресЯщика);
	
	Если СтрокаКонтекста.Box.Organization.Свойство("ShortName") Тогда
		ОрганизацияПодписанта = СтрокаКонтекста.Box.Organization.ShortName;
	Иначе
		ОрганизацияПодписанта = СтрокаКонтекста.Box.Organization.FullName;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьЗаголовокФормы()
	
	Если ПокупательПродавец = "Продавец" Тогда
		НаправлениеПолномочий = "исходящих";
	Иначе
		НаправлениеПолномочий = "входящих";
	КонецЕсли;
	
	Заголовок = "Полномочия для подписания " + НаправлениеПолномочий + " документов";
	
КонецПроцедуры

&НаКлиенте
Функция ТребуетсяПроверитьЗаполнениеОснованияПолномочий()
	
	Результат = Истина;
	
	Если НРег(ВидТитула) = "ucd736"
		И ОбластьПолномочий = "PersonOtherPower" Тогда
		
		Результат = Ложь;
		
	КонецЕсли;
				
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьОснованиеПолномочийПоУмолчанию()
	
	ТребуетсяЗаполнить = Не ЗначениеЗаполнено(ОснованияПолномочий)
						И НРег(ВидТитула) = "ucd736";
						
	Если ТребуетсяЗаполнить Тогда
		ОснованияПолномочий = "Должностные обязанности";
	КонецЕсли;
	
КонецПроцедуры

//} Сервисные методы

//{ обработчики событий формы и элементов

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	ИнициализироватьФорму(Параметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗаполнитьОснованиеПолномочийПоУмолчанию();
	
	УправлениеФормой();

КонецПроцедуры

&НаКлиенте
Процедура СтатусРаботникаПриИзменении(Элемент)
	
	ЗаполнитьОснованиеПолномочийПоУмолчанию();
	СкрытьПоказатьОснованиеПолномочийОрганизации();
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаСвидетельствоОРегистрацииИП_ЗначениеЗаполнитьНажатие(Элемент)
	
	Элементы.ГруппаСвидетельствоОРегистрацииИП_Значение.ТекущаяСтраница = Элементы.СтраницаСвидетельствоОРегистрацииИП_Значение;
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаИныеСведенияЗначениеЗаполнитьНажатие(Элемент)
	
	Элементы.ГруппаИныеСведенияЗначение.ТекущаяСтраница = Элементы.СтраницаИныеСведенияЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	
	Отказ = Ложь;
	
	Если ТипКонтента = ТипыКонтента.utd970 Тогда
		УПД970_ПроверитьЗаполнениеИСохранитьПолномочияПодписанта(Отказ);
	Иначе
		ПроверитьЗаполнениеИСохранитьПолномочияПодписанта(Отказ);
	КонецЕсли;
	
	Если НЕ Отказ Тогда
		Закрыть(ПолномочияПодписанта);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УПД970_ПроверитьЗаполнениеИСохранитьПолномочияПодписанта(Отказ)
	
	ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "Должность");
	
	Если Не Отказ Тогда
		УПД970_СохранитьПолномочияПодписантаНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьЗаполнениеИСохранитьПолномочияПодписанта(Отказ)
	
	ПроверкаЗаполненияДанных(Отказ);
	
	Если Не Отказ Тогда
		СохранитьПолномочияПодписантаНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаЗаполненияДанных(Отказ)
	
	ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "ОбластьПолномочий", "Область полномочий");
	ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "СтатусРаботника"  , "Статус работника");
	
	Если ПодписантСотрудникОрганизации Тогда
		ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "Должность");
	КонецЕсли;
	
	Если ТребуетсяПроверитьЗаполнениеОснованияПолномочий() Тогда
		ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "ОснованияПолномочий", "Основания полномочий");
	КонецЕсли;
	
	Если СтатусРаботника = "OtherOrganizationEmployee" Тогда
		ОсновнаяФорма().ПроверитьЗаполнениеПоляФормы(Отказ, ЭтаФорма, "ОснованияПолномочийОрганизации", "Основания полномочий организации");
	КонецЕсли;
			
КонецПроцедуры

&НаСервере
Процедура СохранитьПолномочияПодписантаНаСервере()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ТипПодписанта = Модуль_Ядро.ПолномочияПодписанта_SignerType(АдресЯщика);
	
	Если ПодписантСотрудникОрганизации Тогда
		НазваниеДолжности = Должность;
	КонецЕсли;
	
	НовыеПолномочияПодписанта = Модуль_Ядро.АПИ_Новый_ExtendedSignerDetailsToPost(
		ТипПодписанта,
		ОбластьПолномочий,
		СтатусРаботника,
		НазваниеДолжности,
		ИныеСведения,
		ОснованияПолномочий,
		ОснованияПолномочийОрганизации,
		СвидетельствоОРегистрацииИП);
		
	Модуль_Ядро.ПолномочияПодписанта_Сохранить(АдресЯщика, ВидТитула, ПокупательПродавец, НовыеПолномочияПодписанта);
	
	ОписаниеПолномочийПодписанта	= Модуль_Ядро.ПолномочияПодписанта_Получить(АдресЯщика, ВидТитула, ПокупательПродавец);
	ПолномочияПодписанта			= ОписаниеПолномочийПодписанта.Данные;
	
КонецПроцедуры

&НаСервере
Процедура УПД970_СохранитьПолномочияПодписантаНаСервере()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	ТипПодписанта = Модуль_Ядро.ПолномочияПодписанта_SignerType(АдресЯщика);
	
	НовыеПолномочияПодписанта = Модуль_Ядро.АПИ_Новый_ExtendedSignerDetailsToPost(
		,
		,
		,
		Должность,
		ИныеСведения,
		,
		,
		СвидетельствоОРегистрацииИП);
		
	Модуль_Ядро.ПолномочияПодписанта_Сохранить(АдресЯщика, ВидТитула, ПокупательПродавец, НовыеПолномочияПодписанта);
	
	ОписаниеПолномочийПодписанта	= Модуль_Ядро.ПолномочияПодписанта_Получить(АдресЯщика, ВидТитула, ПокупательПродавец);
	ПолномочияПодписанта			= ОписаниеПолномочийПодписанта.Данные;
	
КонецПроцедуры


//} обработчики событий формы и элементов

//{	Настройка формы

&НаКлиенте
Процедура СкрытьДолжность()
	
	// если подписант ИП или физ. лицо, то должность не заполняется
	Если НЕ ПодписантСотрудникОрганизации Тогда
		ОсновнаяФорма().ОбновитьСвойствоЭлементаФормы(Элементы.Должность, "Видимость", Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СкрытьПоказатьОснованиеПолномочийОрганизации()
	
	НоваяВидимость = СтатусРаботника = "OtherOrganizationEmployee";
	
	ОсновнаяФорма().ОбновитьСвойствоЭлементаФормы(Элементы.СотрудникИнойОрганизацииОснованиеПолномочийОрганизации, "Видимость", НоваяВидимость);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбора_ОбластьПолномочий()
	
	ОбластиПолномочийПодписанта			= Модуль_ЯдроНаСервере().ПолномочияПодписанта_ОбластиПолномочий(ВидТитула, ПокупательПродавец);
	ПредставленияПолномочийПодписанта	= Модуль_ЯдроНаСервере().ПолномочияПодписанта_ПредставленияПолномочий(ВидТитула);
	
	СписокВыбора = Элементы.ОбластьПолномочий.СписокВыбора;
	
	Для Каждого ДоступнаяОбласть Из ОбластиПолномочийПодписанта Цикл
		СписокВыбора.Добавить(ДоступнаяОбласть, ПредставленияПолномочийПодписанта[ДоступнаяОбласть]);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбора_СтатусРаботника()
	
	СтатусыПодписанта = Модуль_ЯдроНаСервере().ПолномочияПодписанта_СтатусыПодписанта(ВидТитула, ПокупательПродавец);
	ПредставленияСтатусов = Модуль_ЯдроНаСервере().ПолномочияПодписанта_ПредставленияСтатусовПодписанта(ВидТитула, ПокупательПродавец);
	
	СписокВыбора = Элементы.СтатусРаботника.СписокВыбора;
	
	Для Каждого СтатусПодписанта Из СтатусыПодписанта Цикл
		СписокВыбора.Добавить(СтатусПодписанта, ПредставленияСтатусов[СтатусПодписанта]);
	КонецЦикла;
	
КонецПроцедуры

//}	Настройка формы

&НаКлиенте
Процедура УправлениеФормой()

	Если ТипКонтента = ТипыКонтента.utd970 Тогда
		Элементы.ОбластьПолномочий.Видимость = Ложь;
		Элементы.СтатусРаботника.Видимость = Ложь;
		Элементы.СотрудникОрганизацииОснованиеПолномочий.Видимость = Ложь;
		Элементы.СотрудникИнойОрганизацииОснованиеПолномочийОрганизации.Видимость = Ложь;
		Элементы.ГруппаСвидетельствоОРегистрацииИП.Видимость = Ложь;
	Иначе
		СкрытьДолжность();
		СкрытьПоказатьОснованиеПолномочийОрганизации();
	КонецЕсли;
	
КонецПроцедуры
