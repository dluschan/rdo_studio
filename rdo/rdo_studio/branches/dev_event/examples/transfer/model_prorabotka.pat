$Pattern �������_�������: irregular_event
$Relevant_resources
	_�������: ������� Keep
$Time = 0.1
$Body
_�������
	Convert_event
$End

$Pattern �������_�������_������: irregular_event
$Relevant_resources
	_�������: ������� Keep 
	������  : ������  Create 
$Time = 10//�_������_������ (34, 38) 
$Body
_������� 
	Convert_event
		����_������ += 1;
������
    Convert_event trace
		�����_������ = _�������.����_������;
		���_�����    = 60*60;//�_���_����� (900.0, 3600.0);
		�������      = �_���_��������;
$End

$Pattern �������_�������_����������_�������: rule
$Relevant_resources
	������: ������ Keep
$Body
������
	Choice from ������.��������� == ������
	Convert_rule
		����������_�������_�_������ = Int ( ������.���_����� / ������ );
		���������                   = �������������_�������;
		�������_�_������            = ����������_�������_�_������;
$End

$Pattern �������_������������_������_�_�������: rule
$Relevant_resources
	�����������_������: �����������_������� Keep
	������            : ������              Keep
	first
$Body
�����������_������
	Choice from �����������_������.��������� == �������������_�������
			and �����������_������.������    == false
	Convert_rule
		��������� = ��������_������;
������
	Choice from ������.��������� == �������������_�������
			and ������.�������   == �����������_������.�������
	Convert_rule
		���������                = ��������_������;
		�����                    = 0;
		�����_����������_������� = �����������_������.�����_������������_�������;
$End

$Pattern �������_��������_�������: rule
$Relevant_resources
	������            : ������              Keep
	�����������_������: �����������_������� Keep
	first
$Body
������
	Choice from ������.��������� == ��������_������
	Convert_rule
		if (������.�������_�_������ > (������_�_������� - �����������_������.�������_����������_�������))
			����� = ������_�_������� - �����������_������.�������_����������_�������;
		else
			����� = ������.�������_�_������;
		�������_�_������ -= �����;
		���������         = ��������_���������;
�����������_������
	Choice from �����������_������.��������� == ��������_������ 
			and �����������_������.�������   == ������.�������
	Convert_rule
		�������_����������_������� += ������.�����;
		���������                   = ��������_���������;
		������_�_�������           += 1;
$End

$Pattern �������_��������_������������_�������: rule
$Relevant_resources
	�����������_������: �����������_������� Keep
$Body
�����������_������
	Choice from �����������_������.��������� == ��������_���������
	Convert_rule
		if (�������_����������_������� == ������_�_�������)
		{
			������            = true;
			���������         = ��������;
//			������_�_������� -= 1;            //�� �����, ����� ����� ��������� ����� ������
		}
		else
			��������� = �������������_�������;
$End

$Pattern �������_��������_������: rule
$Relevant_resources
	������            : ������              Keep
$Body
������
	Choice from ������.��������� == ��������_���������
	Convert_rule
		if (�������_�_������ == 0)
			��������� = ������������;
		else
			��������� = �������������_�������;
$End

$Pattern �������_��������_���������_�������: rule
$Relevant_resources
    �����������_������: �����������_������� Keep
	_����             : ����                Keep 
	������            : �������             Create
	first
$Body
�����������_������
	Choice from �����������_������.��������� == �������� and ������ == true
	Convert_rule
		��������� = ����������_������_������;
_����
	Choice from _����.����������_�������_�_����� >= ������_�_�������
	Convert_rule
		����������_�������_�_����� -= ������_�_�������;
������
	Convert_rule trace 
		�������          = �����������_������.�������;
		�����_�������    = �����������_������.�����_������������_�������;
		������_�_������� = �����������_������.������_�_�������;
$End

$Pattern �������_����������_������_������_�������: rule
$Relevant_resources
	�����������_������: �����������_������� Keep
$Body
�����������_������
	Choice from �����������_������.��������� == ����������_������_������
	Convert_rule
		�����_������������_������� += 1;
		�������_����������_�������  = 0;
		������                      = false;
		���������                   = �������������_�������;
		������_�_�������            = 0;
$End

$Pattern �������_��������_������� : operation 
$Relevant_resources
	������              : �������  			 Keep Keep
	_�������_�����������: �����_�����������  Keep Keep
	first
$Time = 4//�_��������_������� (3.5, 4.5)
$Body
������
	Choice from ������.��������� == �����������
	Convert_begin
		��������� = ���������;
	Convert_end
		��������� = �����_�_��������;
_�������_�����������
	Choice from _�������_�����������.��������� == �������� 
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

$Pattern �������_�������� : operation 
$Relevant_resources
	������         : �������        Keep     Keep
	_�����_��������: �����_�������� Keep     Keep
	first
$Time = 2//�_�������� (1.8, 2.2)
$Body
������
	Choice from ������.��������� == �����_�_��������
	Convert_begin
		��������� = ��������;
	Convert_end
		��������� = �����_�_��������;
_�����_��������
	Choice from _�����_��������.��������� == ��������
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

$Pattern �������_����������_��_�������� : operation
$Parameters 
	�����_��������: such_as ������.�������
	������_����   : such_as ������_�����������.�������������� 
	�����_����    : such_as ������_�����������.��������������
	����������    : real 
	�����������_  : such_as �������.�����������
	���������_    : such_as �������.���������
$Relevant_resources
	c����� : ������� Keep Keep
$Time = �_�����_�_���� (����������)
$Body
c�����
	Choice from c�����.��������� == �����_�_�������� and c�����.������� == �����_�������� 
			and c�����.�������������� == ������_���� and c�����.����������� == �����������_
	Convert_begin
		���������      = �_����;
	Convert_end
		���������      = ���������_;
		�������������� = �����_����;
$End

$Pattern �������_�����������_������� : operation
$Relevant_resources
	������ : ������� 	 	   Keep Keep
	�������: ����������_������ Keep Keep
	first
$Time = �_�����������_������� (0.9, 1.1)
$Body
������
	Choice from ������.��������� == ������_��_������� 
	Convert_begin
		��������� = �����������_�������;
	Convert_end
		��������� = ������_�������;
�������
	Choice from �������.��������� == �������� and �������.�������������� == ������.��������������
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

//������� ����� ��� �������� ������� � ������ � ��������� "����������_�������_�����"
$Pattern �������_������_��������_�����_������� : rule
$Relevant_resources
	_�����_�����_�����: �����_�����_����� NoChange 
	������			  : ������� Keep
$Body
_�����_�����_����� 
������
	Choice from ������.��������� == ������_�������
	Convert_rule
	if (������.�������������� == _�����_�����_�����.��������������)
		��������� = ����������_�������_�����;
	else 
		��������� = �����_�_��������;
$End

$Pattern �������_�����_����� : operation
$Relevant_resources
	������            : �������           Keep Keep
	_�����_�����_�����: �����_�����_����� Keep Keep
$Time = 4//�_�����_����� (3.5, 4.5)
$Body
������
	Choice from ������.��������� == ����������_�������_�����
	Convert_begin
		��������� = �����_�����;
	Convert_end
		��������� = �����_�_��������;
_�����_�����_�����
	Choice from ��������� == ��������
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

$Pattern �������_��������� : operation
$Relevant_resources
	������          : ������� 		    Keep 	 Keep
	�����_����������: ������_���������� Keep 	 Keep
	first
$Time = 3//�_��������� (2.5, 4.0)
$Body
������
	Choice from ������.��������� == ������_��_���������
	Convert_begin
		��������� = ���������;
	Convert_end
		��������� = ���������;
�����_����������
	Choice from �����_����������.�������������� == ������.�������������� 
			and �����_����������.��������� == ��������
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

$Pattern �������_����������_�����������_������ : rule
$Relevant_resources
	������  : ������� Keep 
	������  : ������  Keep 
	_�������: ������� Keep 
	first
$Body
������
	Choice from ������.��������� == ��������� and ������.������_�_������� > 0
	Convert_rule
	������_�_������� -= 1;
������ 
	Choice from ������.�����_����������_������� == ������.�����_������� 
			and ������.������� == ������.�������
			and ������.��������� == ������������
	Convert_rule 
		��������� = ���������;
_������� 
	Convert_rule
		����������_�����������_������ +=1;
$End

$Pattern �������_��������_�������_��_����� : rule
$Relevant_resources
	������: ������� Keep 
$Body
������
	Choice from ������.��������� == ��������� 
			and ������.������_�_������� == 0
	Convert_rule
		��������� = ����������_�����;
$End

$Pattern �������_����� : operation
$Relevant_resources
	������     : �������      Keep Keep
	�����_�����: ������_����� Keep Keep
$Time = �_����� (2.9, 3.5)  
$Body
������
	Choice from ������.��������� == ����������_�����
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = �����_�_��������;
�����_�����
	Choice from �����_�����.��������� == �������� and �����_�����.�������������� == ������.��������������
	Convert_begin
		��������� = �����;
	Convert_end
		��������� = ��������;
		����������_�����������_�������� +=1;
$End

$Pattern �������_����������_�������_�_�������� : rule
$Relevant_resources
	������: ������� Keep 
$Body
������
	Choice from ������.��������� == �����_�_��������
	Convert_rule
		����������� = ��������;
		��������� = �����_�_��������;
$End

$Pattern �������_��������_�������_�_���� : operation
$Relevant_resources
	������: ������� Keep     Keep
	����  : �����   NoChange Keep
$Time = �_��������_�������_�_���� (3.5, 5)
$Body
������
	Choice from ������.��������� == ������_�_����
	Convert_begin
		��������� = ���������������;
	Convert_end
		��������� = �������������;
����
	Convert_end
		����������_�������_�_����� += ������_�_�������; 
$End

$Pattern �������_��������_������� : rule
$Relevant_resources
	������  : ������� Erase 
	_�������: ������� Keep 
$Body
������
	Choice from ������.��������� == �������������
_������� 
	Convert_rule
		����������_���������_�������� += 1;	
$End

$Pattern �������_��������_������ : rule
$Relevant_resources
	������  : ������ Erase
	_�������: ������� Keep 
$Body
������
	Choice from ������.��������� == ���������
_������� 
	Convert_rule 
		����������_���������_������ += 1;
$End
