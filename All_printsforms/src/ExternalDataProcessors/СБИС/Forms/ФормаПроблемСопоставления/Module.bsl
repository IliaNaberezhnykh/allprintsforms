
#Область include_local_Формы_ФормаПроблемСопоставления

&НаСервере
Процедура СформироватьТаблица(ГруппировкаКолонок, Префикс = "", ПоложениеКолонкиИмя = Неопределено)
	Для Каждого СтруктураКолонки Из ГруппировкаКолонок Цикл
		Если Не ТипЗнч(СтруктураКолонки.Значение) = Тип("Структура") Тогда
			// Добавление реквизита
			ДобавляемыеРеквизиты = Новый Массив;
			НовРеквизит = Новый РеквизитФормы(Префикс + СтруктураКолонки.Ключ, Новый ОписаниеТипов("Строка", ,Новый КвалификаторыСтроки()), "ТаблДок", СтруктураКолонки.Ключ);
			ДобавляемыеРеквизиты.Добавить(НовРеквизит);
			ИзменитьРеквизиты(ДобавляемыеРеквизиты);
			
			// Добавление элемента
			НовПоле = Элементы.Добавить("ТаблДок" + Префикс + СтруктураКолонки.Ключ, Тип("ПолеФормы"), Элементы.Найти(ПоложениеКолонкиИмя));
			НовПоле.Заголовок = СтруктураКолонки.Ключ;
			НовПоле.Вид = ВидПоляФормы.ПолеВвода;
			НовПоле.ПутьКДанным = "ТаблДок" + "." + Префикс + СтруктураКолонки.Ключ;
		Иначе 
			НовПоле = Элементы.Добавить("ТаблДок" + СтруктураКолонки.Ключ, Тип("ГруппаФормы"), Элементы.Найти(ПоложениеКолонкиИмя));
			НовПоле.Заголовок = СтруктураКолонки.Ключ;
			НовПоле.Вид = ВидГруппыФормы.ГруппаКолонок;
			НовПоле.ОтображатьВШапке = Истина;
			
			СформироватьТаблица(СтруктураКолонки.Значение, СтруктураКолонки.Ключ, НовПоле.Имя);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПодготовитьТаблДокУправ(СписокКолонок)
	Для Каждого Поле Из Элементы.ТаблДок.ПодчиненныеЭлементы Цикл
		Элементы.Удалить(Поле);
	КонецЦикла;
	Колонки = ТаблДок.Выгрузить().Колонки;
	УдалитьКолонки = Новый Массив;
	Для Каждого Реквизит Из Колонки Цикл
		УдалитьКолонки.Добавить("ТаблДок." + Реквизит.Имя);
	КонецЦикла;
	ИзменитьРеквизиты(, УдалитьКолонки);
	
	СформироватьТаблица(СписокКолонок,, "ТаблДок");
КонецПроцедуры

#КонецОбласти

#Область include_core_vo2_Формы_ФормаПроблемСопоставления

&НаКлиенте
Функция Показать(Кэш, СтркаТаблицыЗначений) Экспорт
	Перем ТаблВложения;
	ОшибкаЧтения = Ложь;
	//СтруктураПроблем = Кэш.РаботаСJSON.сбисПрочитатьJSON(СтркаТаблицыЗначений.ОшибкиСопоставления);
	
	// Заполнение таблицы
	СоответствиеДокументДанные = Новый Соответствие;
	СтруктураВложения = Кэш.ОбщиеФункции.ПолучитьРазобранныеДанныеВложенияСбис(Кэш, СтркаТаблицыЗначений.СоставПакета[0].Значение, СтркаТаблицыЗначений.СоставПакета[0].Значение.Вложение[0], Новый Структура, Ложь);
	Если СтруктураВложения.СтруктураФайла.Файл.Документ.Свойство("ТаблДок", ТаблВложения) И ТаблВложения.СтрТабл.Количество() Тогда
		СписокКолонок = Новый Структура;
		СформирвоатьСтруктуруКолонок(СписокКолонок, ТаблВложения.СтрТабл[0]);
	КонецЕсли;
	
	// ТаблДок
	#Если ТолстыйКлиентОбычноеПриложение Тогда
		ТаблДок.Колонки.Очистить();
		ЭлементыФормы.ТаблДок.Колонки.Очистить();
		СформироватьТаблицаТонкОбычн(СписокКолонок);
	#Иначе
		ПодготовитьТаблДокУправ(СписокКолонок);
	#КонецЕсли
	
	ЗаполнитьСтрокиТаблДок(ТаблВложения.СтрТабл);
	
	ЭтаФорма.Открыть();
КонецФункции

&НаКлиенте
Процедура СформирвоатьСтруктуруКолонок(СписокКолонок, Группировка)
	ТипСтрока = Новый ОписаниеТипов("Строка");
	Для Каждого Колонка Из Группировка Цикл
		// Убираем лишнее
		Если Найти("Параметр Идентификатор", Колонка.Ключ) Тогда
			Продолжить;
		КонецЕсли;
		
		СписокКолонок.Вставить(Колонка.Ключ, Новый Структура);
		Если ТипЗнч(Колонка.Значение) = Тип("Структура") Тогда
			СформирвоатьСтруктуруКолонок(СписокКолонок[Колонка.Ключ], Колонка.Значение);
		Иначе
			СписокКолонок[Колонка.Ключ] = ТипСтрока;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтрокиТаблДок(МассивСтрок)
	#Если ТолстыйКлиентОбычноеПриложение Тогда
		ТЗ = ТаблДок;
	#Иначе
		ТЗ = ТаблДок.Выгрузить();
	#КонецЕсли
	СтрокаБезИерархии = Новый Структура;
	Для Каждого Строка Из МассивСтрок Цикл
		ПреобразоватьСтроку(Строка, СтрокаБезИерархии);
		НовСтрока = ТаблДок.Добавить();
		Для Каждого Ячейка Из СтрокаБезИерархии Цикл
			Если ТЗ.Колонки.Найти(Ячейка.Ключ) = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			НовСтрока[Ячейка.Ключ] = Ячейка.Значение;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ПреобразоватьСтроку(Строка, Результат, Префик = "")
	Для Каждого Элемент Из Строка Цикл
		Если ТипЗнч(Элемент.Значение) = Тип("Структура") Тогда
			ПреобразоватьСтроку(Элемент.Значение, Результат, Элемент.Ключ + "_");
		Иначе
			Результат.Вставить(Префик + Элемент.Ключ, Элемент.Значение);
		КонецЕсли; 
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ТаблДокПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	Для каждого Ячейка Из ОформлениеСтроки.Ячейки Цикл
		Ячейка.Видимость = Не ТаблДок.Колонки.Найти(Ячейка.Имя) = Неопределено;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти
