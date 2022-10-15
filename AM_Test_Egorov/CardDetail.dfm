object fCardDetail: TfCardDetail
  Left = 0
  Top = 0
  Width = 421
  Height = 212
  Align = alClient
  TabOrder = 0
  DesignSize = (
    421
    212)
  object Label1: TLabel
    Left = 19
    Top = 22
    Width = 27
    Height = 13
    Caption = #1060#1048#1054':'
  end
  object Label2: TLabel
    Left = 19
    Top = 62
    Width = 84
    Height = 13
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
  end
  object Label4: TLabel
    Left = 254
    Top = 62
    Width = 23
    Height = 13
    Caption = #1055#1086#1083':'
  end
  object Label5: TLabel
    Left = 19
    Top = 102
    Width = 48
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
  end
  object Label3: TLabel
    Left = 19
    Top = 142
    Width = 76
    Height = 13
    Caption = #1052#1077#1089#1090#1086' '#1088#1072#1073#1086#1090#1099':'
  end
  object btnSave: TButton
    Left = 247
    Top = 172
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 0
    OnClick = btnSaveClick
    ExplicitLeft = 255
    ExplicitTop = 190
  end
  object btnCancel: TButton
    Left = 328
    Top = 172
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = btnCancelClick
    ExplicitLeft = 336
    ExplicitTop = 190
  end
  object teFio: TEdit
    Left = 112
    Top = 19
    Width = 291
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'teFio'
    ExplicitWidth = 488
  end
  object tePhone: TMaskEdit
    Left = 112
    Top = 99
    Width = 121
    Height = 21
    EditMask = '!\+7(999\)000-0000;1;_'
    MaxLength = 15
    TabOrder = 3
    Text = '+7(   )   -    '
  end
  object teWorkPlace: TEdit
    Left = 112
    Top = 139
    Width = 291
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Text = 'teWorkPlace'
    ExplicitWidth = 488
  end
  object cbGender: TcxComboBox
    Left = 283
    Top = 58
    Properties.DropDownListStyle = lsFixedList
    Properties.Items.Strings = (
      ''
      #1052#1091#1078'.'
      #1046#1077#1085'.')
    TabOrder = 5
    Width = 120
  end
  object dtBirthday: TcxDateEdit
    Left = 112
    Top = 59
    EditValue = 0d
    TabOrder = 6
    Width = 121
  end
end
