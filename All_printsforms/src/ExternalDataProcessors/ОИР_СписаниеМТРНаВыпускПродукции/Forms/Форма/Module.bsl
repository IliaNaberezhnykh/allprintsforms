
&НаСервере
Функция СформироватьСервер()
	ЭтаОбработка 			= РеквизитФормыВЗначение("Объект");
	МассивОбъектов 			= ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объект.Документ);
	КоллекцияПечатныхФорм 	= УправлениеПечатью.ПодготовитьКоллекциюПечатныхФорм("ПГЗ");
	ОбъектыПечати 			= Новый СписокЗначений;
	ПараметрыВывода 		= УправлениеПечатью.ПодготовитьСтруктуруПараметровВывода();
	ЭтаОбработка.Печать(МассивОбъектов, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода);
	ТабличныйДокумент = КоллекцияПечатныхФорм[0].ТабличныйДокумент;

	Возврат ТабличныйДокумент;//СформироватьПечатнуюФорму(Масс, ОбъектыПечати, ПараметрыПечати)
КонецФункции

&НаКлиенте
Процедура Команда1(Команда)
	СформироватьСервер().Показать();
КонецПроцедуры
