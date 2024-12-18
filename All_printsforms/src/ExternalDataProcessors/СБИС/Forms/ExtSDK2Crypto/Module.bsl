
&НаКлиенте
Перем МестныйКэш Экспорт;


////////////////////////////////////////////////////
////////////////////Авторизация/////////////////////
////////////////////////////////////////////////////

//Авторизуется на online.sbis.ru по логину/паролю	
&НаКлиенте
Функция АвторизоватьсяПоЛогинуПаролю(Кэш,Логин,Пароль,Отказ=Ложь) Экспорт 	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.АвторизоватьсяПоЛогинуПаролю(Кэш,Логин,Пароль,Отказ);
КонецФункции	

//Авторизуется на online.sbis.ru по сертификату	
&НаКлиенте
Функция АвторизоватьсяПоСертификату(Кэш,Сертификат,Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.АвторизоватьсяПоСертификату(Кэш,Сертификат,Отказ);
КонецФункции

&НаКлиенте
Функция АвторизоватьсяПоТокену(Кэш,Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.АвторизоватьсяПоТокену(Кэш,Отказ);
КонецФункции

//Функция активирует серверные сертификаты для определенного списка ИНН	
&НаКлиенте
Функция АктивироватьСерверныеСертификаты(Кэш, СписокСертификатов) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.АктивироватьСерверныеСертификаты(Кэш, СписокСертификатов);
КонецФункции

// Заглушка (SDK)
&НаКлиенте
Функция ВключитьОтладку(Кэш, КаталогОтладки) Экспорт
КонецФункции

// Заглушка (SDK)
&НаКлиенте
Функция ОтключитьОтладку(Кэш) Экспорт
КонецФункции

// Изменяет каталог отладки с соответствующими проверками
&НаКлиенте
Функция УстановитьКаталогОтладки(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.УстановитьКаталогОтладки(Кэш);
КонецФункции

&НаКлиенте
Функция ЗакрытьСессию(Кэш) Экспорт 	
	// Закрывает сессию	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ЗакрытьСессию(Кэш);
КонецФункции	

&НаКлиенте
Функция ИнформацияОТекущемПользователе(Кэш) Экспорт
	// Получает информацию о текущем пользователе	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ИнформацияОТекущемПользователе(Кэш);
КонецФункции

&НаКлиенте
Функция ОтправитьКодАвторизации(Кэш, ПараметрыПодтверждения, Отказ) Экспорт
КонецФункции

&НаКлиенте
Функция ПодтвердитьАвторизацию(Кэш, ПараметрыВвода, ПараметрыПодтверждения, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПодтвердитьАвторизацию(Кэш,ПараметрыВвода,ПараметрыПодтверждения,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьДанныеЗашифрованногоФайла(Кэш,Ссылка) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьДанныеЗашифрованногоФайла(Кэш,Ссылка);
КонецФункции

&НаКлиенте
Функция ПолучитьДанныеФайла(Кэш,Ссылка) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьДанныеФайла(Кэш,Ссылка);
КонецФункции

&НаКлиенте
Функция ПолучитьКодАктивацииСертификата(Кэш, Сертификат) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьКодАктивацииСертификата(Кэш, Сертификат);
КонецФункции

&НаКлиенте
Функция ПолучитьНастройкиПлагина(Кэш, ДополнительныеПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьНастройкиПлагина(Кэш, ДополнительныеПараметрыЗапроса, Отказ);	
КонецФункции

&НаКлиенте
Функция ПолучитьСертификатыДляАктивации(Кэш, СписокИНН) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСертификатыДляАктивации(Кэш, СписокИНН);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокДокументовОтгрузки(Кэш) Экспорт
	// Получает список документов реализации с online.sbis.ru 	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокДокументовОтгрузки(Кэш);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокСертификатов(Кэш, filter=Неопределено) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокСертификатов(Кэш, filter);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокСобытий(Кэш, ТипРеестра) Экспорт
	// Получает список документов по событиям с online.sbis.ru	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокСобытий(Кэш, ТипРеестра);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокСобытийПоФильтру(Кэш, filter, ГлавноеОкно) Экспорт
	// Получает список документов по событиям с online.sbis.ru	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокСобытийПоФильтру(Кэш, filter, ГлавноеОкно);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокСертификатовДляАвторизации(Кэш,ТекстОшибки) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокСертификатовДляАвторизации(Кэш,ТекстОшибки);
КонецФункции

&НаКлиенте
функция ПолучитьТикетДляТекущегоПользователя(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьТикетДляТекущегоПользователя(Кэш);
КонецФункции

&НаКлиенте
Функция ПолучитьHTMLВложения(Кэш,ИдДок, Вложение) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьHTMLВложения(Кэш,ИдДок, Вложение);
КонецФункции

&НаКлиенте
Функция ПроверитьПодписиВложения(Кэш,Вложение) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПроверитьПодписиВложения(Кэш,Вложение);
КонецФункции

&НаКлиенте
Функция ПрочитатьДокумент(Кэш,ИдДок,ДопПараметры=Неопределено,Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПрочитатьДокумент(Кэш,ИдДок,ДопПараметры,Отказ);
КонецФункции

&НаКлиенте
Функция СбисВключенРезервныйДомен(Кэш, АдресСервера) Экспорт
	Возврат Ложь;
КонецФункции

&НаКлиенте
Функция СбисВыполнитьДействие(Кэш, СоставПакета, Этап, Действие, Комментарий, ПредставлениеПакета) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисВыполнитьДействие(Кэш, СоставПакета, Этап, Действие, Комментарий, ПредставлениеПакета);
КонецФункции

&НаКлиенте
Функция СбисВыполнитьКоманду(Кэш, Идентификатор,ИмяКоманды, ПредставлениеПакета) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисВыполнитьКоманду(Кэш, Идентификатор,ИмяКоманды, ПредставлениеПакета)
КонецФункции

&НаКлиенте
Функция СбисИдАккаунта(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СбисИдАккаунта(Кэш)
КонецФункции

&НаКлиенте
Функция ПолучитьИдТекущегоАккаунта(Кэш) Экспорт
	Перем СбисИдАккаунта;
	Если Кэш.СБИС.ПараметрыИнтеграции.Свойство("ИдАккаунта", СбисИдАккаунта) Тогда
		Возврат СбисИдАккаунта;
	КонецЕсли;
	Возврат Неопределено;
КонецФункции
&НаКлиенте
Функция Аккордеон_ОтключенныеРазделы() Экспорт
	ОтключенныеРазделы = Новый Структура();
	Возврат ОтключенныеРазделы;
КонецФункции
//Заглушка, подписание в СБИС Плагине
&НаКлиенте
Функция сбисПодписатьВложения(Кэш, attachmentList, СертификатДляПодписания, Алгоритм, Отказ) Экспорт 
	Возврат Ложь;
КонецФункции

&НаКлиенте
Функция СбисПовторитьЭтап(Кэш, ИдДок, ЭтапНазвание, Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисПовторитьЭтап(Кэш, ИдДок, ЭтапНазвание, Отказ);
КонецФункции

&НаКлиенте
Функция СбисПолучитьПараметрыАктуальнойВерсии(Кэш, ПараметрыОбновления, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисПолучитьПараметрыАктуальнойВерсии(Кэш, ПараметрыОбновления, Отказ);
КонецФункции

&НаКлиенте
Функция СбисПолучитьСписокДокументов(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисПолучитьСписокДокументов(Кэш);
КонецФункции

&НаКлиенте
Функция СбисПолучитьСписокЗадач(Кэш, сбисФильтр, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисПолучитьСписокЗадач(Кэш, сбисФильтр, Отказ);
КонецФункции

&НаКлиенте
Функция СбисСохранитьВФайлПоСсылке(Кэш, сбисПараметрыФайла, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисСохранитьВФайлПоСсылке(Кэш, сбисПараметрыФайла, Отказ);
КонецФункции

&НаКлиенте
Функция СбисСессияДействительна(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисСессияДействительна(Кэш);
КонецФункции

&НаКлиенте
Функция СбисУстановитьВремяОжидания(Кэш, ВремяОжидания) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СбисУстановитьВремяОжидания(Кэш, ВремяОжидания);
КонецФункции

&НаКлиенте
Функция СохранитьВложениеПоСсылкеВФайл(Кэш,Ссылка,ИмяФайла) Экспорт 
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СохранитьВложениеПоСсылкеВФайл(Кэш,Ссылка,ИмяФайла);
КонецФункции

&НаКлиенте
Функция СформироватьНастройкиПодключения(Кэш, ИдентификаторСессии = "") Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СформироватьНастройкиПодключения(Кэш, ИдентификаторСессии = "");
КонецФункции

/////////////////////////////////////

&НаКлиенте
Функция ПолучитьСписокИзменений(Кэш, ДопПараметрыФильтра = Неопределено) Экспорт
	// Получает статусы документов сбис
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокИзменений(Кэш, ДопПараметрыФильтра);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокНашихОрганизаций(Кэш, СписокИНН) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокНашихОрганизаций(Кэш, СписокИНН);
КонецФункции

&НаКлиенте
Функция ОтправитьКаталогТоваров(Кэш,КаталогТоваров) Экспорт
	// Получает структуру документа СБИС	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ОтправитьКаталогТоваров(Кэш,КаталогТоваров);
КонецФункции


//////////////// Вспомогательные функции/////////////////////

&НаКлиенте
Функция Включить(Кэш, ДопПараметры=Неопределено, Отказ=Ложь) Экспорт
	// Добавляет СБИСПлагин в Кэш
	ФормаExtSDK = Кэш.ГлавноеОкно.сбисПолучитьФорму("ExtSDK2");
	
	Результат = ФормаExtSDK.Включить(Кэш, ДопПараметры, Отказ);
	Если Отказ Тогда
		Возврат Результат;
	КонецЕсли;
	Кэш.СБИС.ПараметрыИнтеграции.ГенераторФЭД = Ложь;
	
	ПолучитьНастройкиПлагина(Кэш, Новый Структура(), Ложь);
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция Завершить(Кэш, ДопонительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.Завершить(Кэш, ДопонительныеПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СокращенноеФИО(Кэш, ФИО)
	// Формирует сокращенное ФИО из полного	
	ФИО = Кэш.ОбщиеФункции.РазбитьСтрокуВМассивНаКлиенте(ФИО," ");
	
	Фамилия  = ?(ФИО.Количество()>0,ФИО[0],"");
	Имя      = ?(ФИО.Количество()>=2,Лев(ФИО[1],1)+".","");
	Отчество = ?(ФИО.Количество()>=3,Лев(ФИО[2],1)+".","");
	Возврат Фамилия+" "+Имя+Отчество;
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ВыполнитьМетод(Кэш, Метод, Парам=Неопределено, ДопПараметры=Неопределено) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ВыполнитьМетод(Кэш, Метод, Парам, ДопПараметры);
КонецФункции

&НаКлиенте
Функция СбисФайлСКлиентаВBASE64(ПолноеИмяФайла) Экспорт
	# Если НЕ ВебКлиент Тогда
		ДвоичныеДанные = Новый ДвоичныеДанные(ПолноеИмяФайла);
		Возврат сбисФайлНаСервереВBASE64(ДвоичныеДанные);
	# Иначе
		ПомещаемыеФайлы = Новый Массив;
		ПомещаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(ПолноеИмяФайла,""));
		ПомещенныеФайлы = Новый Массив;
		Попытка
			ПоместитьФайлы(ПомещаемыеФайлы,ПомещенныеФайлы,,Ложь, УникальныйИдентификатор);
			Возврат сбисФайлНаСервереВBASE64(ПомещенныеФайлы, Истина);
		Исключение
			Ошибка = ОписаниеОшибки();
		КонецПопытки;
	# КонецЕсли
	Возврат "";
КонецФункции

&НаСервереБезКонтекста
Функция СбисФайлНаСервереВBASE64(Данные, ЭтоВебКлиент=Ложь) Экспорт
	Если ЭтоВебКлиент Тогда
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(Данные[0].Хранение);
	Иначе
		ДвоичныеДанные = Данные;
	КонецЕсли;
	Возврат Base64Строка(ДвоичныеДанные);
КонецФункции

&НаКлиенте
Процедура УстановитьВидимостьОбновитьСтатусы(Кэш) Экспорт
	// Если более часа не проверяли статусы, то выводим красное предупреждение	
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.УстановитьВидимостьОбновитьСтатусы(Кэш);
КонецПроцедуры

//Получает html по xml	
&НаКлиенте
Функция ПолучитьHTMLПоXML(Кэш, Вложение) Экспорт
	Отказ = Ложь;
	ДопПараметрыЗапроса	= Новый Структура("ЕстьРезультат", Истина);
	
	document = Новый Структура( "XML, Тип, Подтип, ВерсияФормата, ПодВерсияФормата", Вложение.XMLДокумента);
	document.Тип = ?(Вложение.Свойство("Тип"), Вложение.Тип, "");
	document.Подтип = ?(Вложение.Свойство("ПодТип"), Вложение.ПодТип, "");
	document.ВерсияФормата = ?(Вложение.Свойство("ВерсияФормата"), Вложение.ВерсияФормата, "");
	document.ПодВерсияФормата = ?(Вложение.Свойство("ПодВерсияФормата") и ЗначениеЗаполнено(Вложение.ПодВерсияФормата), Вложение.ПодВерсияФормата, "");
	
	РезультатЗапроса = Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисОтправитьИОбработатьКоманду(Кэш, "GenerateHTMLFromXMLClient", Новый Структура("Parameter", document), ДопПараметрыЗапроса, Отказ);
	Если Отказ Тогда
		Возврат "";
	КонецЕсли;
	Возврат РезультатЗапроса.HTML;
КонецФункции

&НаКлиенте
Функция СбисПодписант(Кэш, ИНН) Экспорт
	// Получает Информацию о подписанте документа
	СписокСертификатов = ПолучитьСписокСертификатов(Кэш, Новый Структура("ИНН",ИНН));
	Если СписокСертификатов.Количество()>0 Тогда
		Возврат СписокСертификатов[0].Значение;
	Иначе
		Возврат Новый Структура("Должность,ФИО,ИНН");
	КонецЕсли;
КонецФункции

&НаКлиенте
Функция СбисИдентификаторУчастника(Кэш, ИНН, КПП, Название) Экспорт
	// Получает Информацию о контрагенте с онлайна
	Участник = Новый Структура;
	Если СтрДлина(СокрЛП(Инн))=12 Тогда
		СвФЛ = Новый Структура;
		Участник.Вставить("СвФЛ",СвФЛ);
		Участник.СвФЛ.Вставить("ИНН",Инн);
		ФИОСтруктура = Кэш.ОбщиеФункции.сбисПолучитьФИОИзНазвания(Название);
		Участник.СвФЛ.Вставить("Фамилия",ФИОСтруктура.Фамилия);
		Участник.СвФЛ.Вставить("Имя",ФИОСтруктура.Имя);
		Участник.СвФЛ.Вставить("Отчество",ФИОСтруктура.Отчество);
	Иначе
		СвЮЛ = Новый Структура;
		Участник.Вставить("СвЮЛ",СвЮЛ);
		Участник.СвЮЛ.Вставить("ИНН",ИНН);
		Участник.СвЮЛ.Вставить("КПП",КПП);
		Участник.СвЮЛ.Вставить("Название",Название);
	КонецЕсли;
	оКонтрагент = ПолучитьИнформациюОКонтрагенте(Кэш, Участник);
	Если оКонтрагент<>Ложь Тогда
		Возврат оКонтрагент.Идентификатор;
	КонецЕсли;
	Возврат "";
КонецФункции

////////////////////////////////////////////////////
//////////////Серверные настройки вызов/////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция ДоступныСерверныеНастройки() Экспорт
	Возврат Истина;
КонецФункции	

&НаКлиенте
Функция ПолучитьXslt(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьXslt(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьИни(Кэш, ИмяМетода, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьИни(Кэш, ИмяМетода, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ);
КонецФункции

&НаКлиенте
Функция ЗаписатьConnection(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ЗаписатьConnection(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокConnection(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокConnection(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокConfig(Кэш, ПараметрыСообщения, ДополнительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьСписокConfig(Кэш,ПараметрыСообщения,ДополнительныеПараметры,Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////////Статистика вызов//////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция СбисОтправитьСообщениеСтатистики(Кэш, СообщениеСтатистики, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисОтправитьСообщениеСтатистики(Кэш,СообщениеСтатистики,Отказ);
КонецФункции

&НаКлиенте
Функция СбисОтправитьСообщениеОшибки(Кэш, СообщениеОбОшибке, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисОтправитьСообщениеОшибки(Кэш,СообщениеОбОшибке,Отказ);
КонецФункции

&НаКлиенте
Функция сбисПроверкаОбновления(Кэш, ИнформацияОТекущейВерсии, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисПроверкаОбновления(Кэш, ИнформацияОТекущейВерсии, Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////Сотрудники////////////////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция СбисЗаписатьСотрудников(Кэш, ДанныеСотрудников, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисЗаписатьСотрудников(Кэш, ДанныеСотрудников, Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////////////Отправка//////////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция ОтправитьПакетыДокументов(Кэш, МассивПакетов, РезультатОтправки=Неопределено) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ОтправитьПакетыДокументов(Кэш, МассивПакетов, РезультатОтправки);
КонецФункции

&НаКлиенте
Процедура СбисПолучитьОтветыПоОтправке(Кэш) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СбисПолучитьОтветыПоОтправке(Кэш);
КонецПроцедуры

&НаКлиенте
Функция Отправка_ПодготовитьСтруктуруПакета(Кэш, ПараметрыВыполнить, ДополнительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.Отправка_ПодготовитьСтруктуруПакета(Кэш, ПараметрыВыполнить, Новый Структура("Шифрование", Истина), Отказ);
КонецФункции

&НаКлиенте
Процедура Отправка_Вызов(Кэш, ПараметрыОтправки, ДопПараметры) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.Отправка_Вызов(Кэш, ПараметрыОтправки, ДопПараметры);
КонецПроцедуры

////////////////////////////////////////////////////
///////////////////////Обертки//////////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция СБИСПлагин_ИнформацияОСлужебныхЭтапах(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ИнформацияОСлужебныхЭтапах(Кэш, param, ДопПараметры, Отказ);
КонецФункции

//Обработка внешнего файла. Пока в двоичных данных.
&НаКлиенте
Процедура СБИСПлагин_ОбработатьВнешнийФайл(Кэш, ПараметрыВложения, ПараметрыПодготовки) Экспорт
	ПараметрыВложения.Файл.Вставить("ДвоичныеДанные", СбисФайлСКлиентаВBASE64(ПараметрыВложения.Вложение.ПолноеИмяФайла));
КонецПроцедуры

&НаКлиенте
Процедура СБИСПлагин_ОбработатьXMLФайл(Кэш, ДанныеФайла, ПараметрыПодготовки) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ОбработатьXMLФайл(Кэш, ДанныеФайла, ПараметрыПодготовки);
КонецПроцедуры
	
&НаКлиенте
Функция СБИСПлагин_ПрочитатьДокумент(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ПрочитатьДокумент(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ПрочитатьДокументКакHTML(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ПрочитатьДокументКакHTML(Кэш, param, ДопПараметры, Отказ);
КонецФункции	

&НаКлиенте
Функция СБИСПлагин_ИмпортНоменклатурыИзCML(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ИмпортНоменклатурыИзCML(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_РасшифроватьФайл(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_РасшифроватьФайл(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ЗаписатьСотрудника(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ЗаписатьСотрудника(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ОбработкаСлужебныхЭтапов(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ОбработкаСлужебныхЭтапов(Кэш, param, ДопПараметры, Отказ);
КонецФункции
	
&НаКлиенте
Функция СБИСПлагин_СписокДокументов(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_СписокДокументов(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокИзменений(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_СписокИзменений(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокНашихОрганизаций(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_СписокНашихОрганизаций(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокДокументовПоСобытиям(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_СписокДокументовПоСобытиям(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ЗаписатьВложение(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСПлагин_ЗаписатьВложение(Кэш, param, ДопПараметры, Отказ);
КонецФункции


#Область include_core_vo2_СпособыОбмена_ExtSDKCrypto_2_ВнешниеОбертки

&НаКлиенте
Функция СБИС_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ПодготовитьДействие(Кэш, document_in, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ПодготовитьДействие(Кэш, document_in, ДопПараметры, Отказ);
КонецФункции	

&НаКлиенте
Функция СБИС_СериализоватьСтрокуВBase64(Кэш, ПараметрыСериализовать, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_СериализоватьСтрокуВBase64(Кэш, ПараметрыСериализовать, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_СохранитьПоСсылкеВФайл(Кэш, ПараметрыФайла, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_СохранитьПоСсылкеВФайл(Кэш, ПараметрыФайла, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_СписокИзменений(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_СписокИзменений(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ТекущаяДата(Кэш, Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ТекущаяДата(Кэш, Отказ);
КонецФункции	
	
&НаКлиенте
Функция СБИС_ИнформацияОКонтрагенте(Кэш, СтруктураКонтрагента, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ИнформацияОКонтрагенте(Кэш, СтруктураКонтрагента, ДопПараметры, Отказ)
КонецФункции

&НаКлиенте
Функция СБИС_ПолучитьИнформациюОТекущемПользователе(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ПолучитьИнформациюОТекущемПользователе(Кэш, param, ДопПараметры, Отказ);
КонецФункции 

&НаКлиенте
Функция СБИС_ПолучитьСписокАккаунтов(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ПолучитьСписокАккаунтов(Кэш, param, ДопПараметры, Отказ);
КонецФункции 

&НаКлиенте
Функция СБИС_ПереключитьАккаунт(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ПереключитьАккаунт(Кэш, param, ДопПараметры, Отказ);
КонецФункции 

&НаКлиенте
Функция СБИС_ПолучитьПараметрыПакетаДляОткрытияОнлайн(ОписаниеПакета, ДопПараметры) Экспорт
	Возврат ДопПараметры.Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИС_ПолучитьПараметрыПакетаДляОткрытияОнлайн(ОписаниеПакета, ДопПараметры);
КонецФункции 

&НаКлиенте
Функция АПИ3_ИнитКоннекшен(ПараметрыИнит, ДопПараметрыВызова) Экспорт
	Возврат ДопПараметрыВызова.Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.АПИ3_ИнитКоннекшен(ПараметрыИнит, ДопПараметрыВызова);
КонецФункции

#КонецОбласти

////////////////////////////////////////////////////
///////////////////Прочие функции///////////////////
////////////////////////////////////////////////////

//Получает список организаций с необработанными этапами и запускает для них обработку служебных документов
&НаКлиенте
Функция ОбработкаСлужебныхДокументов(Кэш) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ОбработкаСлужебныхДокументов(Кэш)	
КонецФункции

//Получает Информацию о контрагенте с онлайна
&НаКлиенте
Функция ПолучитьИнформациюОКонтрагенте(Кэш, СтруктураКонтрагента) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.ПолучитьИнформациюОКонтрагенте(Кэш, СтруктураКонтрагента);
КонецФункции

//Получает текущую дату в миллисекундах с начала 1970г
&НаКлиенте
Функция сбисТекущаяДатаМСек(Кэш) Экспорт
	Отказ				= Ложь;
	ДопПараметрыЗапроса	= Новый Структура("ЕстьРезультат, ВремяОжиданияОтвета", Истина, 30);
	
	Результат = Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.сбисОтправитьИОбработатьКоманду(Кэш, "getMillisecondsSinceEpoch", Новый Структура, ДопПараметрыЗапроса, Отказ);
	Если Отказ Тогда
		Возврат 0;
	КонецЕсли;
	Попытка
		Результат = Число(Результат);
	Исключение
		Возврат 0;
	КонецПопытки;
	Возврат Результат;
КонецФункции

&НаКлиенте
функция СБИСЗаписатьВложения(Кэш,СоставПакета, Вложение) экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK2.СБИСЗаписатьВложения(Кэш, СоставПакета, Вложение);
КонецФункции

