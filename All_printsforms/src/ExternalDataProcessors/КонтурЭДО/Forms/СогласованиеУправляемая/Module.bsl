
&НаСервере
Перем ОбработкаОбъект;

//{		Сервисные методы
	
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

//}		Сервисные методы


//{		Сервисные процедуры и функции

&НаКлиенте
Процедура УстановитьГоловноеПодразделение()
	
	DepartmentId = "00000000-0000-0000-0000-000000000000";
	
КонецПроцедуры

&НаСервере
Процедура УстановитьГоловноеПодразделениеНаСервере()
	
	DepartmentId = "00000000-0000-0000-0000-000000000000";
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСотрудникаПоУмолчанию()
	
	UserId = Элементы.Сотрудник.СписокВыбора[0].Значение;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСотрудникаПоУмолчаниюНаСервере()
	
	UserId = Элементы.Сотрудник.СписокВыбора[0].Значение;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьМаршрутПоУмолчанию()
	
	RouteId = Элементы.Маршрут.СписокВыбора[0].Значение;
	
КонецПроцедуры


&НаКлиенте
Процедура ПередатьНаСогласованиеПодпись()
	
	Результат = Модуль_ЯдроНаКлиенте().Контракт_Маршрутизация();
	
	Результат.Действие		= Действие;
	Результат.UserId		= UserId;
	Результат.DepartmentId	= DepartmentId;
	Результат.Комментарий	= Комментарий;
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередатьПоМаршруту()
	
	Если Не ЗначениеЗаполнено(RouteId) Тогда
		Сообщить("Выберите маршрут");
		Возврат;
	КонецЕсли;
	
	Результат = Модуль_ЯдроНаКлиенте().Контракт_Маршрутизация();
	
	Результат.Действие		= Действие;
	Результат.RouteId		= RouteId;
	Результат.Комментарий	= Комментарий;
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередатьВПодразделение()
	
	Результат = Модуль_ЯдроНаКлиенте().Контракт_Маршрутизация();
	
	Результат.BoxId			= BoxId;
	Результат.DepartmentId	= DepartmentId;
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура СогласоватьОтказатьВСогласовании()
	
	Результат = Модуль_ЯдроНаКлиенте().Контракт_Маршрутизация();
	
	Результат.Действие		= Действие;
	Результат.Комментарий	= Комментарий;
	
	Закрыть(Результат);
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьСписокВыбораЭлементаФормыНаСервере(СписокВыбораЭлементаФормы, Источник)
	
	СписокВыбораЭлементаФормы.Очистить();
	
	Для Каждого ЭлементСЗ Из Источник Цикл
		СписокВыбораЭлементаФормы.Добавить(ЭлементСЗ.Значение, ЭлементСЗ.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ДоступныеДействияФормы()
	
	Результат = Новый Структура;
	Результат.Вставить("ПередатьНаСогласование",	"ПередатьНаСогласование");
	Результат.Вставить("ПередатьНаПодпись",			"ПередатьНаПодпись");
	Результат.Вставить("ПередатьПоМаршруту",		"ПередатьПоМаршруту");
	Результат.Вставить("Согласование",				"Согласование");
	Результат.Вставить("ОтказВСогласовании",		"ОтказВСогласовании");
	Результат.Вставить("ПередатьВПодразделение",	"ПередатьВПодразделение");
	Результат.Вставить("ОтказВЗапросеПодписи",		"ОтказВЗапросеПодписи");
	
	Возврат Результат;

КонецФункции

&НаСервере
Процедура ОбновитьСписокСотрудников()
	
	// добавляет в список выбора сотрудников, имеющих соответствующие права в Подразделение (_departmentId)
	
	СписокСотрудников = Новый СписокЗначений;
	
	Для Каждого OrganizationUser Из OrganizationUsersList.Users Цикл
		
		Если OrganizationUser.Id = OrganizationUsersList.CurrentUserId 	// Не будем отправлять самому себе
			ИЛИ OrganizationUser.Permissions.AuthorizationPermission.IsBlocked Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ УСотрудникаЕстьДоступВПодразделение(OrganizationUser, DepartmentId) Тогда
			Продолжить;
		КонецЕсли;

		Если Действие = ДоступныеДействияФормы().ПередатьНаСогласование
			И OrganizationUser.Permissions.CanAddResolutions Тогда
				
				СписокСотрудников.Добавить(OrganizationUser.Id, OrganizationUser.Name);
				
		ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьНаПодпись
			И OrganizationUser.Permissions.CanSignDocuments Тогда
			
			СписокСотрудников.Добавить(OrganizationUser.Id, OrganizationUser.Name);
			
		КонецЕсли;
		
	КонецЦикла;

	СписокСотрудников.СортироватьПоПредставлению();
		
	СписокСотрудников.Вставить(0, "", "Любой с правом "
										+ ?(Действие = ДоступныеДействияФормы().ПередатьНаСогласование, "согласования", "подписи"));
	
	ЗаполнитьСписокВыбораЭлементаФормыНаСервере(Элементы.Сотрудник.СписокВыбора, СписокСотрудников);
	
КонецПроцедуры

&НаСервере
Функция УСотрудникаЕстьДоступВПодразделение(OrganizationUser, DepartmentId)
	
	Permissions = OrganizationUser.Permissions;
	
	Если Permissions.DocumentAccessLevel = "AllDocuments" Тогда
		
		Возврат Истина;  // Права ко всем подразделениям
		
	ИначеЕсли	Permissions.DocumentAccessLevel = "SelectedDepartments"
				И Permissions.SelectedDepartmentIds.Найти(DepartmentId) <> Неопределено Тогда
		
		Возврат Истина;  // доступ только в указанные подразделения, и DepartmentId как раз туда входит
		
	ИначеЕсли	Permissions.DocumentAccessLevel = "DepartmentOnly"
				И Permissions.UserDepartmentId = DepartmentId Тогда
		
		Возврат Истина;  // Доступ только в свое подразделение, и оно совпадает с желаемым
		
	
	ИначеЕсли	Permissions.DocumentAccessLevel = "DepartmentAndSubdepartments"
				И ПодразделениеВходитВРодителя(DepartmentId, Permissions.UserDepartmentId) Тогда
				
		Возврат Истина;  // Доступ в подразделение Permissions.UserDepartmentId и все его дочерние

	Иначе
		
		Возврат Ложь;  // все остальные случаи
		
	КонецЕсли;
		
КонецФункции

&НаСервере
Функция ПодразделениеВходитВРодителя(Знач ИД, ИДРодителя)
	
	// Проверяем, есть ли подразделение ИДРодителя в родителях подразделения ИД
	
	Пока Истина Цикл
		
		Если ИД = ИДРодителя Тогда
			Возврат Истина;
		ИначеЕсли ИД = "00000000-0000-0000-0000-000000000000" Тогда
			Возврат Ложь;  // мы добрались до самого верха подразделений и не встретили желаемого
		Иначе
			ИД = ИерархияПодразделений.НайтиПоЗначению(ИД).Представление;  // поменяем ИД на ИД его родителя и проверим снова
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

//}		Сервисные процедуры и функции


//{		Обработчики событий формы и элементов

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Действие	= Параметры.Действие;
	BoxId		= Параметры.BoxId;
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	Если Не ЗначениеЗаполнено(Действие) Тогда
		
		Сообщить("Не указан режим работы формы");
		Отказ = Истина;
		Возврат;
		
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(BoxId) Тогда
		
		Сообщить("Не указан boxId");
		Отказ = Истина;
		Возврат;
		
	КонецЕсли;
	
	Если Ложь
		Или Действие = ДоступныеДействияФормы().ПередатьНаСогласование
		Или Действие = ДоступныеДействияФормы().ПередатьНаПодпись Тогда
		
		ЗаполнитьСписокВыбораПодразделения(Элементы.Подразделение.СписокВыбора);
		OrganizationUsersList = Модуль_ЯдроНаСервере().ПользователиОрганизации(BoxId);
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьПоМаршруту Тогда
		
		МаршрутыСогласованияОрганизации = Модуль_ЯдроНаСервере().МаршрутыСогласованияОрганизации(BoxId);
		ЗаполнитьСписокВыбораЭлементаФормыНаСервере(Элементы.Маршрут.СписокВыбора, МаршрутыСогласованияОрганизации);
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьВПодразделение Тогда
		
		ЗаполнитьСписокВыбораПодразделения(Элементы.КонечноеПодразделение.СписокВыбора);
		
	КонецЕсли;
	
	НастроитьФормуНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораПодразделения(СписокВыбора)
	
	ПодразделенияОрганизации = Модуль_ЯдроНаСервере().ПодразделенияОрганизации(BoxId);
	СформироватьИерархиюПодразделений(ПодразделенияОрганизации);
	
	СписокВыбора.Очистить();
	СписокВыбора.Добавить("00000000-0000-0000-0000-000000000000", "Головное подразделение");
	
	Для Каждого Подразделение Из ПодразделенияОрганизации Цикл
		
		Значение		= Подразделение.DepartmentId;
		Представление	= Подразделение.Name + ?(ЗначениеЗаполнено(Подразделение.Abbreviation), " (" + Подразделение.Abbreviation + ")", "");
		СписокВыбора.Добавить(Значение, Представление);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
// Departments - массив http://api-docs.diadoc.ru/ru/latest/proto/Department.html
Процедура СформироватьИерархиюПодразделений(Departments)
	
	// Заполняет СписокЗначений "ИерархияПодразделений"
	// По нему потом будем проверять вхождение одного подразделения в иерархию другого
	
	ИерархияПодразделений.Очистить();
	
	Для Каждого Department Из Departments Цикл
		ИерархияПодразделений.Добавить(Department.DepartmentId, Department.ParentDepartmentId);
		// Значение - ИД, Представление - ИД родителя. Т.е. элементы с Представление = "00000000-0000-0000-0000-000000000000" будут идти первым уровнем
	КонецЦикла;
	
КонецПроцедуры


&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	
	ОбновитьСписокСотрудников();
	УстановитьСотрудникаПоУмолчанию();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодразделениеОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	УстановитьГоловноеПодразделение();
	ОбновитьСписокСотрудников();
	УстановитьСотрудникаПоУмолчанию();
	
КонецПроцедуры

&НаКлиенте
Процедура КонечноеПодразделениеОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьГоловноеПодразделение();
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьСотрудникаПоУмолчанию();
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	UserId = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура МаршрутОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	УстановитьМаршрутПоУмолчанию();
	
КонецПроцедуры

&НаКлиенте
Процедура МаршрутОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	RouteId = ВыбранноеЗначение;
	
КонецПроцедуры


&НаКлиенте
Процедура ВыполнитьДействие(Команда)

	Если Действие = ДоступныеДействияФормы().ПередатьВПодразделение Тогда
		
		КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().ПередатьВПодразделение;
		ДействиеМетрики		= "Перемещение в подразделение";
		
		Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_НажатиеКнопки("Перемещение в подразделение", КатегорияМетрики, ДействиеМетрики);
		
		ПередатьВПодразделение();
		
	Иначе
		
		КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().Согласование;
		ДействиеМетрики		= ОсновнаяФорма().Метрика_НазваниеДействияМаршрутизации(Действие);
		
		Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_НажатиеКнопки("Согласование", КатегорияМетрики, ДействиеМетрики);
		
		Если Действие = ДоступныеДействияФормы().ПередатьНаСогласование
			Или Действие = ДоступныеДействияФормы().ПередатьНаПодпись Тогда
			
			ПередатьНаСогласованиеПодпись();
			
		ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьПоМаршруту Тогда
			
			ПередатьПоМаршруту();
			
		ИначеЕсли Действие = ДоступныеДействияФормы().Согласование
			Или Действие = ДоступныеДействияФормы().ОтказВСогласовании
			Или Действие = ДоступныеДействияФормы().ОтказВЗапросеПодписи Тогда
			
			СогласоватьОтказатьВСогласовании();	
			
		КонецЕсли;	
		
	КонецЕсли;
		
КонецПроцедуры

//}		Обработчики событий формы и элементов


//{		Настройка формы

&НаСервере
Процедура НастроитьФормуНаСервере()
	
	Если Действие = ДоступныеДействияФормы().ПередатьНаСогласование Тогда
		НастроитьФормуПередачиНаСогласованиеНаСервере();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьНаПодпись Тогда
		НастроитьФормуПередачиНаПодписьНаСервере();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьПоМаршруту Тогда
		НастроитьФормуПередачиПоМаршрутуНаСервере();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().Согласование Тогда
		НастроитьФормуСогласованияНаСервере();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ОтказВСогласовании Тогда
		НастроитьФормуОтказаВСогласовании();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ПередатьВПодразделение Тогда
		НастроитьФормуПередачиВПодразделение();
		
	ИначеЕсли Действие = ДоступныеДействияФормы().ОтказВЗапросеПодписи Тогда
		НастроитьФормуОтказаВЗапросеПодписи();	
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПередачиНаСогласованиеНаСервере()
	
	Заголовок	= "Передача на согласование";
	Комментарий	= "";
	
	Элементы.Комментарий.Заголовок		= "Комментарий";
	Элементы.ФормаВыполнить.Заголовок	= "Передать";
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Истина;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
	ПараметрыСтроки = Новый КвалификаторыСтроки(500); 
	Элементы.Комментарий.ОграничениеТипа = Новый ОписаниеТипов("Строка", , ПараметрыСтроки);

	УстановитьГоловноеПодразделениеНаСервере();
	ОбновитьСписокСотрудников();
	УстановитьСотрудникаПоУмолчаниюНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПередачиНаПодписьНаСервере()
	
	Заголовок	= "Передача на подпись";
	Комментарий	= "";

	Элементы.Комментарий.Заголовок		= "Комментарий";
	Элементы.ФормаВыполнить.Заголовок	= "Передать";
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Истина;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
	ПараметрыСтроки = Новый КвалификаторыСтроки(500); 
	Элементы.Комментарий.ОграничениеТипа = Новый ОписаниеТипов("Строка", , ПараметрыСтроки);

	УстановитьГоловноеПодразделениеНаСервере();
	ОбновитьСписокСотрудников();
	УстановитьСотрудникаПоУмолчаниюНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПередачиПоМаршрутуНаСервере()
	
	Заголовок	= "Передача по маршруту";
	Комментарий	= "";
	
	Элементы.Комментарий.Заголовок		= "Комментарий";
	Элементы.ФормаВыполнить.Заголовок	= "Передать";
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Ложь;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Истина;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуСогласованияНаСервере()
	
	Заголовок	= "Согласование документа";
	Комментарий	= "";
	
	Элементы.Комментарий.Заголовок		= "Результат согласования и комментарий будут видны только сотрудникам вашей организации";
	Элементы.ФормаВыполнить.Заголовок	= "Согласовать";
	
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Ложь;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуОтказаВСогласовании()
	
	Заголовок	= "Отказ в согласовании документа";
	Комментарий	= "";
	
	Элементы.Комментарий.Заголовок		= "Результат согласования и комментарий будут видны только сотрудникам вашей организации";
	Элементы.ФормаВыполнить.Заголовок 	= "Отказать";
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Ложь;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПередачиВПодразделение()
	
	Заголовок = "Перемещение в подразделение";
	
	Элементы.ФормаВыполнить.Заголовок = "Переместить";
		
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Ложь;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Истина;
	Элементы.Комментарий.Видимость							= Ложь;
	
	УстановитьГоловноеПодразделениеНаСервере();
		
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуОтказаВЗапросеПодписи()
	
	Заголовок	= "Отказ в запросе подписи сотруднику";
	Комментарий	= "";
	
	Элементы.Комментарий.Заголовок		= "Результат отказа в запросе подписи и комментарий будут видны только сотрудникам вашей организации";
	Элементы.ФормаВыполнить.Заголовок	= "Отказать";
	
	Элементы.ГруппаПередачаНаСогласованиеПодпись.Видимость	= Ложь;
	Элементы.ГруппаПередачаПоМаршруту.Видимость				= Ложь;
	Элементы.ГруппаПередачаВПодразделение.Видимость			= Ложь;
	Элементы.Комментарий.Видимость							= Истина;
	
КонецПроцедуры

//}		Настройка формы
