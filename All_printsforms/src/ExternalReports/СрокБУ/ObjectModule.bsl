
#Область РегистрацияОбработки

Функция СведенияОВнешнейОбработке() Экспорт
     
    ОбщееОписание = "Срок БУ";
     
    ПараметрыРегистрации  = Новый Структура;
    ПараметрыРегистрации.Вставить("Вид"             , "ДополнительныйОтчет"); 
    ПараметрыРегистрации.Вставить("БезопасныйРежим" , Ложь);
     
	ПараметрыРегистрации.Вставить("Представление", НСтр("ru = 'Срок БУ'"));
 	ПараметрыРегистрации.Вставить("Наименование", НСтр("ru = 'Срок БУ'"))  ;
   ПараметрыРегистрации.Вставить("Версия"          , "1.1.0");
    ПараметрыРегистрации.Вставить("Информация"      , ОбщееОписание);
     
     
    ТаблицаКоманд = ПолучитьТаблицуКоманд();
     
    ДобавитьКоманду(ТаблицаКоманд, ОбщееОписание, "1", "ОткрытиеФормы", Истина, "");
    ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд); 
     
    Возврат ПараметрыРегистрации;
     
Конецфункции
 
Функция ПолучитьТаблицуКоманд()
     
    Команды = Новый ТаблицаЗначений;
    Команды.Колонки.Добавить("Представление"        , Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("Идентификатор"        , Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("Использование"        , Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("ПоказыватьОповещение" , Новый ОписаниеТипов("Булево"));
    Команды.Колонки.Добавить("Модификатор"          , Новый ОписаниеТипов("Строка"));
     
    Возврат Команды;
     
КонецФункции
 
Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
     
    НоваяКоманда = ТаблицаКоманд.Добавить();
    НоваяКоманда.Представление        = Представление;
    НоваяКоманда.Идентификатор        = Идентификатор;
    НоваяКоманда.Использование        = Использование;
    НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
    НоваяКоманда.Модификатор          = Модификатор;
     
КонецПроцедуры
#КонецОбласти

