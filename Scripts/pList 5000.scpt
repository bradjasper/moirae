FasdUAS 1.101.10   ��   ��    k             i         I     ������
�� .aevtoappnull  �   � ****��  ��    k    � 	 	  
  
 l     ��  ��      select System_Snapshot     �   .   s e l e c t   S y s t e m _ S n a p s h o t      r         n         1   
 ��
�� 
psxp  l    
 ����  I    
���� 
�� .sysostdfalis    ��� null��    �� ��
�� 
dflc  4    �� 
�� 
psxf  m       �   n / U s e r s / J C / L i b r a r y / L o g s / D i s c i p l i n e / L o g / S y s t e m _ S n a p s h o t s /��  ��  ��    o      ���� 0 
chosenfile 
chosenFile      l   ��������  ��  ��        Z    -   ����  >    ! " ! l    #���� # I   �� $��
�� .corecnte****       **** $ n     % & % 2    ��
�� 
cha  & o    ���� 0 
chosenfile 
chosenFile��  ��  ��   " m    ���� �   k    ) ' '  ( ) ( I   &�� * +
�� .sysodlogaskr        TEXT * m     , , � - - � U m .   P l e a s e   c h o o s e   a   S y s t e m   S n a p s h o t   f i l e   t h a t   i s   i n   t h e   f o l d e r   i t   s h o u l d   b e   i n . . . + �� . /
�� 
btns . J      0 0  1�� 1 m     2 2 � 3 3  O K��   / �� 4��
�� 
dflt 4 m   ! "���� ��   )  5�� 5 L   ' )����  ��  ��  ��     6 7 6 l  . .��������  ��  ��   7  8 9 8 l  . .�� : ;��   :   make file to write to    ; � < < ,   m a k e   f i l e   t o   w r i t e   t o 9  = > = r   . 7 ? @ ? I   . 3�������� 0 makewritefile makeWriteFile��  ��   @ o      ���� 0 	writefile 	writeFile >  A B A I  8 o�� C D
�� .rdwrwritnull���     **** C l  8 _ E���� E b   8 _ F G F b   8 [ H I H b   8 W J K J b   8 C L M L b   8 ? N O N m   8 ; P P � Q Q   S y s t e m   S n a p s h o t : O 1   ; >��
�� 
tab  M 1   ? B��
�� 
tab  K l  C V R���� R c   C V S T S l  C R U���� U n   C R V W V 7  D R�� X Y
�� 
cha  X m   H L���� d Y m   M Q���� v W o   C D���� 0 
chosenfile 
chosenFile��  ��   T m   R U��
�� 
TEXT��  ��   I o   W Z��
�� 
ret  G o   [ ^��
�� 
ret ��  ��   D �� Z [
�� 
refn Z o   b e���� 0 	writefile 	writeFile [ �� \��
�� 
wrat \ m   h k��
�� rdwreof ��   B  ] ^ ] l  p p��������  ��  ��   ^  _ ` _ r   p v a b a J   p r����   b o      ���� 0 optallwinlist optAllWinList `  c d c r   w } e f e J   w y����   f o      ����  0 optallnamelist optAllNameList d  g h g r   ~ � i j i J   ~ �����   j o      ���� "0 optonscrwinlist optOnScrWinList h  k l k r   � � m n m J   � �����   n o      ���� $0 optonscrnamelist optOnScrNameList l  o p o r   � � q r q J   � �����   r o      ���� "0 optallwinownpid optAllWinOwnPID p  s t s r   � � u v u J   � �����   v o      ���� &0 optonscrwinownpid optOnScrWinOwnPID t  w x w l  � ���������  ��  ��   x  y z y O   �� { | { k   �� } }  ~  ~ l  � ��� � ���   �   read in pList data    � � � � &   r e a d   i n   p L i s t   d a t a   � � � r   � � � � � l  � � ����� � n   � � � � � 1   � ���
�� 
pcnt � 4   � ��� �
�� 
plif � o   � ����� 0 
chosenfile 
chosenFile��  ��   � o      ���� 0 thedata theData �  ��� � O   �� � � � k   �� � �  � � � l  � ��� � ���   � #  make list of OptionAll items    � � � � :   m a k e   l i s t   o f   O p t i o n A l l   i t e m s �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 2  � ���
�� 
plii � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� 0 
optalllist 
optAllList �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � , & make list of OptionOnScreenOnly items    � � � � L   m a k e   l i s t   o f   O p t i o n O n S c r e e n O n l y   i t e m s �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 2  � ���
�� 
plii � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� "0 optonscreenlist optOnScreenList �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � M G optionAll window names and window numbers corresponding to application    � � � � �   o p t i o n A l l   w i n d o w   n a m e s   a n d   w i n d o w   n u m b e r s   c o r r e s p o n d i n g   t o   a p p l i c a t i o n �  ��� � Y   �� ��� � ��� � k   �� � �  � � � r   � � � � n   � � � � 1  ��
�� 
valL � n   � � � � 4  	�� �
�� 
plii � m   � � � � � $ k C G W i n d o w O w n e r N a m e � n   �	 � � � 4  	�� �
�� 
plii � o  ���� 0 thecount theCount � n   � � � � 4   ��� �
�� 
plii � m  ����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� 0 
winownname 
winOwnName �  � � � r  8 � � � n  4 � � � 1  04��
�� 
valL � n  0 � � � 4  )0�� �
�� 
plii � m  ,/ � � � � �  k C G W i n d o w N u m b e r � n  ) � � � 4  $)�� �
�� 
plii � o  '(���� 0 thecount theCount � n  $ � � � 4  $� �
� 
plii � m  "#�~�~  � 4  �} �
�} 
plii � m  �|�|  � o      �{�{ 0 winnum winNum �  � � � r  9X � � � n  9T � � � 1  PT�z
�z 
valL � n  9P � � � 4  IP�y �
�y 
plii � m  LO � � � � � " k C G W i n d o w O w n e r P I D � n  9I � � � 4  DI�x �
�x 
plii � o  GH�w�w 0 thecount theCount � n  9D � � � 4  ?D�v �
�v 
plii � m  BC�u�u  � 4  9?�t �
�t 
plii � m  =>�s�s  � o      �r�r 0 	winownpid 	winOwnPID �  � � � r  Yf � � � b  Yb � � � o  Y\�q�q "0 optallwinownpid optAllWinOwnPID � J  \a � �  ��p � o  \_�o�o 0 	winownpid 	winOwnPID�p   � o      �n�n "0 optallwinownpid optAllWinOwnPID �  � � � r  gl �  � m  gh�m�m    o      �l�l 0 indx   �  l mm�k�j�i�k  �j  �i    l mm�h�h   I C make list of kCGWindowNumber's with respect to kCGWindowOwnerNames    � �   m a k e   l i s t   o f   k C G W i n d o w N u m b e r ' s   w i t h   r e s p e c t   t o   k C G W i n d o w O w n e r N a m e s �g Z  m�	
�f	 E  mt o  mp�e�e  0 optallnamelist optAllNameList o  ps�d�d 0 
winownname 
winOwnName
 k  w�  r  w| m  wx�c�c   o      �b�b 0 indx    Y  }��a�` Z  ���_�^ = �� o  ���]�] 0 
winownname 
winOwnName n  �� 4  ���\
�\ 
cobj o  ���[�[ 0 i   o  ���Z�Z  0 optallnamelist optAllNameList k  ��  !  r  ��"#" o  ���Y�Y 0 i  # o      �X�X 0 indx  ! $�W$  S  ���W  �_  �^  �a 0 i   m  ���V�V  I ���U%�T
�U .corecnte****       ****% o  ���S�S  0 optallnamelist optAllNameList�T  �`   &'& r  ��()( n  ��*+* 4  ���R,
�R 
cobj, o  ���Q�Q 0 indx  + o  ���P�P 0 optallwinlist optAllWinList) o      �O�O 0 winlistitem winListItem' -.- r  ��/0/ b  ��121 o  ���N�N 0 winlistitem winListItem2 o  ���M�M 0 winnum winNum0 o      �L�L 0 winlistitem winListItem. 3�K3 r  ��454 o  ���J�J 0 winlistitem winListItem5 n      676 4  ���I8
�I 
cobj8 o  ���H�H 0 indx  7 o  ���G�G 0 optallwinlist optAllWinList�K  �f   k  ��99 :;: r  ��<=< b  ��>?> o  ���F�F  0 optallnamelist optAllNameList? J  ��@@ A�EA o  ���D�D 0 
winownname 
winOwnName�E  = o      �C�C  0 optallnamelist optAllNameList; B�BB r  ��CDC b  ��EFE o  ���A�A 0 optallwinlist optAllWinListF J  ��GG H�@H J  ��II J�?J o  ���>�> 0 winnum winNum�?  �@  D o      �=�= 0 optallwinlist optAllWinList�B  �g  �� 0 thecount theCount � m   � ��<�<  � I  � ��;K�:
�; .corecnte****       ****K o   � ��9�9 0 
optalllist 
optAllList�:  ��  ��   � n   � �LML 1   � ��8
�8 
pcntM o   � ��7�7 0 thedata theData��   | m   � �NN�                                                                                  sevs   alis    �  Macintosh HD               �a�H+     tSystem Events.app                                                ����        ����  	                CoreServices    �bu      ��C       t   0   /  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   z OPO l ���6�5�4�6  �5  �4  P QRQ l ���3ST�3  S "  check duplicate within list   T �UU 8   c h e c k   d u p l i c a t e   w i t h i n   l i s tR VWV r  �
XYX I  ��2Z�1�2  0 checkduplicate checkDuplicateZ [�0[ o  ��/�/ 0 optallwinlist optAllWinList�0  �1  Y o      �.�. 0 hasduplicate hasDuplicateW \]\ I :�-^_
�- .rdwrwritnull���     ****^ b  "`a` b  bcb b  ded b  fgf b  hih m  jj �kk 4 O p t i o n A l l   h a s   d u p l i c a t e s ?  i 1  �,
�, 
tab g 1  �+
�+ 
tab e 1  �*
�* 
tab c o  �)�) 0 hasduplicate hasDuplicatea o  !�(
�( 
ret _ �'lm
�' 
refnl o  %(�&�& 0 	writefile 	writeFilem �%no
�% 
wratn m  +.�$
�$ rdwreof o �#p�"
�# 
as  p m  14�!
�! 
TEXT�"  ] qrq r  ;Gsts I  ;C� u��   0 checkduplicate checkDuplicateu v�v o  <?�� "0 optonscrwinlist optOnScrWinList�  �  t o      �� 0 hasduplicate hasDuplicater wxw I Hs�yz
� .rdwrwritnull���     ****y b  H[{|{ b  HW}~} b  HS� b  HO��� m  HK�� ��� F O p t i o n O n S c r e e n O n l y   h a s   d u p l i c a t e s ?  � 1  KN�
� 
tab � 1  OR�
� 
tab ~ o  SV�� 0 hasduplicate hasDuplicate| o  WZ�
� 
ret z ���
� 
refn� o  ^a�� 0 	writefile 	writeFile� ���
� 
wrat� m  dg�
� rdwreof � ���
� 
as  � m  jm�
� 
TEXT�  x ��� r  t���� I  t|����  0 checkduplicate checkDuplicate� ��� o  ux�� "0 optallwinownpid optAllWinOwnPID�  �  � o      �� 0 hasduplicate hasDuplicate� ��� I ���
��
�
 .rdwrwritnull���     ****� b  ����� b  ����� m  ���� ��� N O p t i o n A l l   d u p l i c a t e   w i n d o w   o w n e r   P I D s ?  � o  ���	�	 0 hasduplicate hasDuplicate� o  ���
� 
ret � ���
� 
refn� o  ���� 0 	writefile 	writeFile� ���
� 
wrat� m  ���
� rdwreof � ���
� 
as  � m  ���
� 
TEXT�  � ��� l ��� �����   ��  ��  � ��� l ��������  � 7 1 check window number uniqueness withing each list   � ��� b   c h e c k   w i n d o w   n u m b e r   u n i q u e n e s s   w i t h i n g   e a c h   l i s t� ��� l ��������  � A ;set isUnique to checkUnique(optAllWinList, optOnScrWinList)   � ��� v s e t   i s U n i q u e   t o   c h e c k U n i q u e ( o p t A l l W i n L i s t ,   o p t O n S c r W i n L i s t )� ��� l ��������  � � |	write "OptionAll unique window number? " & tab & tab & tab & tab & isUnique & return to writeFile starting at eof as string   � ��� � 	 w r i t e   " O p t i o n A l l   u n i q u e   w i n d o w   n u m b e r ?   "   &   t a b   &   t a b   &   t a b   &   t a b   &   i s U n i q u e   &   r e t u r n   t o   w r i t e F i l e   s t a r t i n g   a t   e o f   a s   s t r i n g� ��� l ��������  � B <	set isUnique to checkUnique(optOnScrWinList, optAllWinList)   � ��� x 	 s e t   i s U n i q u e   t o   c h e c k U n i q u e ( o p t O n S c r W i n L i s t ,   o p t A l l W i n L i s t )� ��� l ��������  � � �	write "OptionOnScreenOnly unique window number? " & tab & tab & isUnique & return & return to writeFile starting at eof as string   � ��� 	 w r i t e   " O p t i o n O n S c r e e n O n l y   u n i q u e   w i n d o w   n u m b e r ?   "   &   t a b   &   t a b   &   i s U n i q u e   &   r e t u r n   &   r e t u r n   t o   w r i t e F i l e   s t a r t i n g   a t   e o f   a s   s t r i n g� ��� l ����������  ��  ��  � ��� l ��������  � 9 3 check window owner PID uniqueness within each list   � ��� f   c h e c k   w i n d o w   o w n e r   P I D   u n i q u e n e s s   w i t h i n   e a c h   l i s t� ��� l ����������  ��  ��  � ��� l ��������  � Q K check if Option All contains all of Option On Screen Only kCGWindowNumbers   � ��� �   c h e c k   i f   O p t i o n   A l l   c o n t a i n s   a l l   o f   O p t i o n   O n   S c r e e n   O n l y   k C G W i n d o w N u m b e r s� ��� l ����������  ��  ��  � ��� l ����������  ��  ��  � ��� I  ��������� 0 writetofile writeToFile� ��� o  ������  0 optallnamelist optAllNameList� ��� o  ������ 0 optallwinlist optAllWinList� ���� o  ������ 0 	writefile 	writeFile��  ��  � ���� Z  ��������� = ����� o  ������ 0 	writefile 	writeFile� l �������� I ��������
�� .aevtodocnull  �    alis��  ��  ��  ��  � I �������
�� .rdwrclosnull���     ****� o  ������ 0 	writefile 	writeFile��  ��  ��  ��    ��� l     ��������  ��  ��  � ��� l     ������  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �������  0 checkduplicate checkDuplicate� ���� o      ���� 0 alist aList��  ��  � k     +�� ��� Z     )������ =     ��� l    ������ I    �����
�� .corecnte****       ****� o     ���� 0 alist aList��  ��  ��  � m    ����  � L   
 �� m   
 �� ���  N o p e��  � k    )�� ��� r    ��� n    ��� 1    ��
�� 
rest� o    ���� 0 alist aList� o      ���� 0 therest theRest� ���� Z    )������ E       o    ���� 0 therest theRest n     4    ��
�� 
cobj m    ����  o    ���� 0 alist aList� L      m     �  Y e a��  � I   # )������  0 checkduplicate checkDuplicate 	��	 o   $ %���� 0 therest theRest��  ��  ��  � 
��
 l  * *��������  ��  ��  ��  �  l     ��������  ��  ��    l     ����   / ) ========================================    � R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  i     I      ������ 0 checkunique checkUnique  o      ���� 0 alist aList �� o      ����  0 listcomparedto listComparedTo��  ��   k     �  Y     ����� k    �   !"! r    #$# n    %&% 4    ��'
�� 
cobj' o    ���� 0 i  & o    ���� 0 alist aList$ o      ���� 0 anitem anItem" ()( r    (*+* 7   &��,-
�� 
cobj, l   .����. [    /0/ o    ���� 0 i  0 m    ���� ��  ��  - l   %1����1 I   %��2��
�� .corecnte****       ****2 o     !���� 0 alist aList��  ��  ��  + o      ���� 0 therest theRest) 343 Z   ) 556����5 E   ) ,787 o   ) *���� 0 therest theRest8 o   * +���� 0 anitem anItem6 L   / 199 m   / 0:: �;;  N o p e��  ��  4 <��< Z   6 �=>����= E   6 9?@? o   6 7����  0 listcomparedto listComparedTo@ o   7 8���� 0 anitem anItem> k   < }AA BCB r   < @DED J   < >����  E o      ���� &0 newlistcomparedto newListComparedToC F��F Y   A }G��HI��G Z   K xJK��LJ =  K QMNM o   K L���� 0 anitem anItemN n   L POPO 4   M P��Q
�� 
cobjQ o   N O���� 0 j  P o   L M����  0 listcomparedto listComparedToK k   T kRR STS r   T iUVU b   T gWXW o   T U���� &0 newlistcomparedto newListComparedToX 7  U f��YZ
�� 
cobjY l  Z ^[����[ [   Z ^\]\ o   [ \���� 0 j  ] m   \ ]���� ��  ��  Z l  _ e^����^ I  _ e��_��
�� .corecnte****       ****_ o   ` a����  0 listcomparedto listComparedTo��  ��  ��  V o      ���� &0 newlistcomparedto newListComparedToT `�`  S   j k�  ��  L r   n xaba b   n vcdc o   n o�~�~ &0 newlistcomparedto newListComparedTod J   o uee f�}f n   o sghg 4   p s�|i
�| 
cobji o   q r�{�{ 0 j  h o   o p�z�z  0 listcomparedto listComparedTo�}  b o      �y�y &0 newlistcomparedto newListComparedTo�� 0 j  H m   D E�x�x I o   E F�w�w  0 listcomparedto listComparedTo��  ��  ��  ��  ��  �� 0 i   m    �v�v  l   	j�u�tj I   	�sk�r
�s .corecnte****       ****k o    �q�q 0 alist aList�r  �u  �t  ��   l�pl Z   � �mn�oom =   � �pqp l  � �r�n�mr I  � ��ls�k
�l .corecnte****       ****s o   � ��j�j 0 alist aList�k  �n  �m  q m   � ��i�i  n L   � �tt m   � �uu �vv  Y e p�o  o k   � �ww xyx r   � �z{z n   � �|}| 4   � ��h~
�h 
cobj~ m   � ��g�g } o   � ��f�f 0 alist aList{ o      �e�e 0 anitem anItemy � r   � ���� n   � ���� 1   � ��d
�d 
rest� o   � ��c�c 0 alist aList� o      �b�b 0 therest theRest� ��a� Z   � ������ =  � ���� I   � ��`��_�` "0 comparetomylist compareToMyList� ��� o   � ��^�^ 0 anitem anItem� ��]� o   � ��\�\ 0 therest theRest�]  �_  � m   � ��� ���  N o p e� L   � ��� m   � ��� ���  N o p e� ��� =  � ���� I   � ��[��Z�[ (0 comparetootherlist compareToOtherList� ��� m   � ��Y
�Y 
cobj� ��� J   � ��X�X  � ��W� o   � ��V�V  0 listcomparedto listComparedTo�W  �Z  � m   � ��� ���  N o p e� ��U� L   � ��� m   � ��� ���  N o p e�U  � I   � ��T��S�T 0 checkunique checkUnique� ��� o   � ��R�R 0 therest theRest� ��Q� o   � ��P�P  0 listcomparedto listComparedTo�Q  �S  �a  �p   ��� l     �O���O  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �N��M�N "0 comparetomylist compareToMyList� ��� m      �L
�L 
cobj� ��K� m      �J
�J 
list�K  �M  � Z     ���I�� E     ��� m     �H
�H 
list� m    �G
�G 
cobj� L    �� m    �� ���  N o p e�I  � L    �� m    �� ���  Y e p� ��� l     �F���F  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �E��D�E (0 comparetootherlist compareToOtherList� ��� o      �C�C 0 anitem anItem� ��� o      �B�B 0 
returnlist 
returnList� ��A� o      �@�@ 0 evillist evilList�A  �D  � Z     ^���?�� =     ��� l    ��>�=� I    �<��;
�< .corecnte****       ****� o     �:�: 0 evillist evilList�;  �>  �=  � m    �9�9  � L   
 �� m   
 �� ���  Y e p�?  � Z    ^���8�7� E    ��� o    �6�6 0 evillist evilList� o    �5�5 0 anitem anItem� k    Z�� ��� r    ��� J    �4�4  � o      �3�3 0 evilrest evilRest� ��2� Y    Z��1���0� Z   ( U���/�� =  ( .��� n  ( ,��� 4   ) ,�.�
�. 
cobj� o   * +�-�- 0 i  � o   ( )�,�, 0 evillist evilList� o   , -�+�+ 0 anitem anItem� k   1 H�� ��� r   1 F��� b   1 D��� o   1 2�*�* 0 evilrest evilRest� l  2 C��)�(� n  2 C��� 7  3 C�'��
�' 
cobj� l  7 ;��&�%� [   7 ;��� o   8 9�$�$ 0 i  � m   9 :�#�# �&  �%  � l  < B��"�!� I  < B� ��
�  .corecnte****       ****� o   = >�� 0 evillist evilList�  �"  �!  � o   2 3�� 0 evillist evilList�)  �(  � o      �� 0 evilrest evilRest�  �   S   G H�  �/  � r   K U b   K S o   K L�� 0 evilrest evilRest J   L R � n  L P 4   M P�	
� 
cobj	 o   N O�� 0 i   o   L M�� 0 evillist evilList�   o      �� 0 evilrest evilRest�1 0 i  � m    �� � I   #�
�
� .corecnte****       ****
 o    �� 0 evillist evilList�  �0  �2  �8  �7  �  l     ��   / ) ========================================    � R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  i     I      ���� 0 makewritefile makeWriteFile�  �   k     1  r      4     �
� 
psxf m     � 4 / U s e r s / J C / D e s k t o p / d o o o . t x t o      �� 0 filetoreturn fileToReturn  Q       r   
 !"! I  
 �
#$
�
 .rdwropenshor       file# o   
 �	�	 0 filetoreturn fileToReturn$ �%�
� 
perm% m    �
� boovtrue�  " o      �� 0 filetoreturn fileToReturn R      �&'
� .ascrerr ****      � ****& o      �� 0 errmsg errMsg' �(�
� 
errn( o      � �  0 errornumber errorNumber�    k     )) *+* l   ��,-��  , g a		display dialog ("An unknown error occurred: " & errorNumber as text) & return & return & errMsg   - �.. � 	 	 d i s p l a y   d i a l o g   ( " A n   u n k n o w n   e r r o r   o c c u r r e d :   "   &   e r r o r N u m b e r   a s   t e x t )   &   r e t u r n   &   r e t u r n   &   e r r M s g+ /��/ I    ��0��
�� .rdwrclosnull���     ****0 o    ���� 0 filetoreturn fileToReturn��  ��   121 I  ! .��34
�� .rdwrwritnull���     ****3 b   ! $565 m   ! "77 �88 P = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =6 o   " #��
�� 
ret 4 ��9:
�� 
refn9 o   % &���� 0 filetoreturn fileToReturn: ��;<
�� 
wrat; m   ' (��
�� rdwreof < ��=��
�� 
as  = m   ) *��
�� 
TEXT��  2 >��> L   / 1?? o   / 0���� 0 filetoreturn fileToReturn��   @A@ l     ��������  ��  ��  A BCB l     ��DE��  D / ) ========================================   E �FF R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =C G��G i    HIH I      ��J���� 0 writetofile writeToFileJ KLK o      ���� 0 namelist nameListL MNM o      ���� 0 winlist winListN O��O o      ���� 0 filetowriteto fileToWriteTo��  ��  I Y     WP��QR��P k    RSS TUT I   ��VW
�� .rdwrwritnull���     ****V b    XYX n    Z[Z 4    ��\
�� 
cobj\ o    ���� 0 i  [ o    ���� 0 namelist nameListY m    ]] �^^  :  W ��_`
�� 
refn_ o    ���� 0 filetowriteto fileToWriteTo` ��ab
�� 
wrata m    ��
�� rdwreof b ��c��
�� 
as  c m    ��
�� 
TEXT��  U ded Y    Hf��gh��f I  0 C��ij
�� .rdwrwritnull���     ****i b   0 ;klk l  0 9m����m c   0 9non n   0 7pqp 4   4 7��r
�� 
cobjr o   5 6���� 0 j  q n   0 4sts 4   1 4��u
�� 
cobju o   2 3���� 0 i  t o   0 1���� 0 winlist winListo m   7 8��
�� 
TEXT��  ��  l m   9 :vv �ww  ,  j ��xy
�� 
refnx o   < =���� 0 filetowriteto fileToWriteToy ��z��
�� 
wratz m   > ?��
�� rdwreof ��  �� 0 j  g m   " #���� h l  # +{����{ I  # +��|��
�� .corecnte****       ****| n   # '}~} 4   $ '��
�� 
cobj o   % &���� 0 i  ~ o   # $���� 0 winlist winList��  ��  ��  ��  e ���� I  I R����
�� .rdwrwritnull���     ****� o   I J��
�� 
ret � ����
�� 
refn� o   K L���� 0 filetowriteto fileToWriteTo� �����
�� 
wrat� m   M N��
�� rdwreof ��  ��  �� 0 i  Q m    ���� R I   	�����
�� .corecnte****       ****� o    ���� 0 namelist nameList��  ��  ��       ���������������������������������������  � ��������������������������������������������������������
�� .aevtoappnull  �   � ****��  0 checkduplicate checkDuplicate�� 0 checkunique checkUnique�� "0 comparetomylist compareToMyList�� (0 comparetootherlist compareToOtherList�� 0 makewritefile makeWriteFile�� 0 writetofile writeToFile�� 0 
chosenfile 
chosenFile�� 0 	writefile 	writeFile�� 0 optallwinlist optAllWinList��  0 optallnamelist optAllNameList�� "0 optonscrwinlist optOnScrWinList�� $0 optonscrnamelist optOnScrNameList�� "0 optallwinownpid optAllWinOwnPID�� &0 optonscrwinownpid optOnScrWinOwnPID�� 0 thedata theData�� 0 
optalllist 
optAllList�� "0 optonscreenlist optOnScreenList�� 0 
winownname 
winOwnName�� 0 winnum winNum�� 0 	winownpid 	winOwnPID�� 0 indx  �� 0 winlistitem winListItem�� 0 hasduplicate hasDuplicate��  ��  ��  ��  � �� ��������
�� .aevtoappnull  �   � ****��  ��  � ������ 0 thecount theCount�� 0 i  � <���� ������������ ,�� 2����~�}�| P�{�z�y�x�w�v�u�t�s�r�q�p�o�n�mN�l�k�j�i�h�g�f ��e ��d ��c�b�a�`�_�^j�]�\���[�Z�Y
�� 
dflc
�� 
psxf
�� .sysostdfalis    ��� null
�� 
psxp�� 0 
chosenfile 
chosenFile
�� 
cha 
�� .corecnte****       ****�� �
�� 
btns
�� 
dflt� 
�~ .sysodlogaskr        TEXT�} 0 makewritefile makeWriteFile�| 0 	writefile 	writeFile
�{ 
tab �z d�y v
�x 
TEXT
�w 
ret 
�v 
refn
�u 
wrat
�t rdwreof 
�s .rdwrwritnull���     ****�r 0 optallwinlist optAllWinList�q  0 optallnamelist optAllNameList�p "0 optonscrwinlist optOnScrWinList�o $0 optonscrnamelist optOnScrNameList�n "0 optallwinownpid optAllWinOwnPID�m &0 optonscrwinownpid optOnScrWinOwnPID
�l 
plif
�k 
pcnt�j 0 thedata theData
�i 
plii
�h 
valL�g 0 
optalllist 
optAllList�f "0 optonscreenlist optOnScreenList�e 0 
winownname 
winOwnName�d 0 winnum winNum�c 0 	winownpid 	winOwnPID�b 0 indx  
�a 
cobj�` 0 winlistitem winListItem�_  0 checkduplicate checkDuplicate�^ 0 hasduplicate hasDuplicate
�] 
as  �\ �[ 0 writetofile writeToFile
�Z .aevtodocnull  �    alis
�Y .rdwrclosnull���     ****���*�)��/l �,E�O��-j � ���kv�k� OhY hO*j+ E` Oa _ %_ %�[�\[Za \Za 2a &%_ %_ %a _ a a � OjvE` OjvE` OjvE` OjvE` OjvE` OjvE`  Oa !^*a "�/a #,E` $O_ $a #,D*a %k/a %k/a %-a &,E` 'O*a %l/a %k/a %-a &,E` (Ok_ 'j kh  *a %k/a %k/a %�/a %a )/a &,E` *O*a %k/a %k/a %�/a %a +/a &,E` ,O*a %k/a %k/a %�/a %a -/a &,E` .O_ _ .kv%E` OjE` /O_ _ * djE` /O .k_ j kh _ *_ a 0�/  �E` /OY h[OY��O_ a 0_ //E` 1O_ 1_ ,%E` 1O_ 1_ a 0_ //FY _ _ *kv%E` O_ _ ,kvkv%E` [OY��UUO*_ k+ 2E` 3Oa 4_ %_ %_ %_ 3%_ %a _ a a a 5a a 6 O*_ k+ 2E` 3Oa 7_ %_ %_ 3%_ %a _ a a a 5a a 6 O*_ k+ 2E` 3Oa 8_ 3%_ %a _ a a a 5a a 6 O*_ _ _ m+ 9O_ *j :  _ j ;Y h� �X��W�V���U�X  0 checkduplicate checkDuplicate�W �T��T �  �S�S 0 alist aList�V  � �R�Q�R 0 alist aList�Q 0 therest theRest� �P��O�N�M
�P .corecnte****       ****
�O 
rest
�N 
cobj�M  0 checkduplicate checkDuplicate�U ,�j  j  �Y ��,E�O���k/ �Y *�k+ OP� �L�K�J���I�L 0 checkunique checkUnique�K �H��H �  �G�F�G 0 alist aList�F  0 listcomparedto listComparedTo�J  � �E�D�C�B�A�@�?�E 0 alist aList�D  0 listcomparedto listComparedTo�C 0 i  �B 0 anitem anItem�A 0 therest theRest�@ &0 newlistcomparedto newListComparedTo�? 0 j  � �>�=:u�<�;���:���9
�> .corecnte****       ****
�= 
cobj
�< 
rest�; "0 comparetomylist compareToMyList�: (0 comparetootherlist compareToOtherList�9 0 checkunique checkUnique�I � �k�j  kh ��/E�O*[�\[Z�k\Z�j  2E�O�� �Y hO�� FjvE�O ;k�kh ���/  �*[�\[Z�k\Z�j  2%E�OY ���/kv%E�[OY��Y h[OY��O�j  j  �Y :��k/E�O��,E�O*��l+ �  �Y *�jv�m+ �  �Y 	*��l+ � �8��7�6���5�8 "0 comparetomylist compareToMyList�7 �4��4 �  �3�2
�3 
cobj
�2 
list�6  �  � �1�0��
�1 
list
�0 
cobj�5 �� �Y �� �/��.�-���,�/ (0 comparetootherlist compareToOtherList�. �+��+ �  �*�)�(�* 0 anitem anItem�) 0 
returnlist 
returnList�( 0 evillist evilList�-  � �'�&�%�$�#�' 0 anitem anItem�& 0 
returnlist 
returnList�% 0 evillist evilList�$ 0 evilrest evilRest�# 0 i  � �"��!
�" .corecnte****       ****
�! 
cobj�, _�j  j  �Y Q�� JjvE�O ?k�j  kh ��/�  ��[�\[Z�k\Z�j  2%E�OY ���/kv%E�[OY��Y h� � ������  0 makewritefile makeWriteFile�  �  � ���� 0 filetoreturn fileToReturn� 0 errmsg errMsg� 0 errornumber errorNumber� ������7��������
� 
psxf
� 
perm
� .rdwropenshor       file� 0 errmsg errMsg� ���

� 
errn� 0 errornumber errorNumber�
  
� .rdwrclosnull���     ****
� 
ret 
� 
refn
� 
wrat
� rdwreof 
� 
as  
� 
TEXT� 
� .rdwrwritnull���     ****� 2)��/E�O ��el E�W X  �j O��%������ O�� �	I������	 0 writetofile writeToFile� ��� �  ���� 0 namelist nameList� 0 winlist winList� 0 filetowriteto fileToWriteTo�  � �� ������� 0 namelist nameList�  0 winlist winList�� 0 filetowriteto fileToWriteTo�� 0 i  �� 0 j  � ����]��������������v����
�� .corecnte****       ****
�� 
cobj
�� 
refn
�� 
wrat
�� rdwreof 
�� 
as  
�� 
TEXT�� 
�� .rdwrwritnull���     ****�� 
�� 
ret � X Vk�j  kh ��/�%������ 	O (k��/j  kh ��/�/�&�%���� 	[OY��O����� 	[OY��� ��� / U s e r s / J C / L i b r a r y / L o g s / D i s c i p l i n e / L o g / S y s t e m _ S n a p s h o t s / S y s t e m _ S n a p s h o t s _ 2 0 0 9 - 0 5 - 2 1 / S y s t e m _ S n a p s h o t _ 2 0 0 9 - 0 5 - 2 1   1 8 : 1 2 : 3 9   - 0 5 0 0 . p l i s t� .furlfile://localhost/Users/JC/Desktop/dooo.txt� ����� �  �������� ����� �  ����������������������������!R��!D��!4��!3��!.��!-��!*��!)��!'��!$��!#��! ��!� ����� �  ��������������������E���������� ����� �  ����������A���������� ����� �  ����������������}��|��{��x��w��v��u� ����� �  ������	���� ����� �  ������ ��� ~� ����� �  ���� !� ����� �  �������� ��� 
 X c o d e� ���  S a f a r i� ���  S c r i p t   E d i t o r� ���  S k i m� ���  M a i l� ���  D r o p b o x� ���  C a f f e i n e� ������  ��  � ������  ��  � ����� #� # ������������������������������������������������������������������������������������������������������������������ ��������������������������������������������� ��� ��� ��� ��� ��� �� ������  ��  � �� ���� N���
�� 
plif� ��� M a c i n t o s h   H D : U s e r s : J C : L i b r a r y : L o g s : D i s c i p l i n e : L o g : S y s t e m _ S n a p s h o t s : S y s t e m _ S n a p s h o t s _ 2 0 0 9 - 0 5 - 2 1 : S y s t e m _ S n a p s h o t _ 2 0 0 9 - 0 5 - 2 1   1 8 / 1 2 / 3 9   - 0 5 0 0 . p l i s t
�� 
pcnt� ����� #� # ������������������������������������ ������� 0 kCGWindowNumber  ��!R� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ��� 2 M o i r a e   -   D e b u g g e r   C o n s o l e� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  �`� �� �� 0 kCGWindowBounds    ���� 0 X   @w�      ���� 
0 Height   @|�      ���� 	0 Width   @��      ������ 0 Y   @wp     ��   ��	
�� 0 kCGWindowOwnerName  	 � 
 X c o d e
 �������� 0 kCGWindowOwnerPID  �����  � ������ 0 kCGWindowNumber  ��!D ���� 0 kCGWindowAlpha   ?�       �� 0 kCGWindowName   � , M o i r a e   -   B u i l d   R e s u l t s �~�}�~ 0 kCGWindowStoreType  �}  �|�{�| 0 kCGWindowSharingState  �{  �z�y�z 0 kCGWindowLayer  �y   �x�w�x 0 kCGWindowMemoryUsage  �w  �` �v�v 0 kCGWindowBounds   �u�u 0 X   @^@      �t�t 
0 Height   @       �s�s 	0 Width   @@      �r�q�r 0 Y   @F�     �q   �p �p 0 kCGWindowOwnerName   �!! 
 X c o d e  �o�n�m�o 0 kCGWindowOwnerPID  �n��m  � �l�k"�l 0 kCGWindowNumber  �k!4" �j#$�j 0 kCGWindowAlpha  # ?�      $ �i�h%�i 0 kCGWindowStoreType  �h % �g�f&�g 0 kCGWindowSharingState  �f & �e�d'�e 0 kCGWindowLayer  �d  ' �c�b(�c 0 kCGWindowMemoryUsage  �b#`( �a)*�a 0 kCGWindowBounds  ) �`+,�` 0 X  +         , �_-.�_ 
0 Height  - @0      . �^/0�^ 	0 Width  / @0      0 �]1�\�] 0 Y  1 @��     �\  * �[23�[ 0 kCGWindowOwnerName  2 �44 
 X c o d e3 �Z�Y�X�Z 0 kCGWindowOwnerPID  �Y��X  � �W�V5�W 0 kCGWindowNumber  �V!35 �U67�U 0 kCGWindowAlpha  6 ?�      7 �T�S8�T 0 kCGWindowStoreType  �S 8 �R�Q9�R 0 kCGWindowSharingState  �Q 9 �P�O:�P 0 kCGWindowLayer  �O  : �N�M;�N 0 kCGWindowMemoryUsage  �M  `; �L<=�L 0 kCGWindowBounds  < �K>?�K 0 X  >         ? �J@A�J 
0 Height  @ @`      A �IBC�I 	0 Width  B @`      C �HD�G�H 0 Y  D @�      �G  = �FEF�F 0 kCGWindowOwnerName  E �GG 
 X c o d eF �E�D�C�E 0 kCGWindowOwnerPID  �D��C  � �B�AH�B 0 kCGWindowNumber  �A!.H �@IJ�@ 0 kCGWindowAlpha  I ?�      J �?KL�? 0 kCGWindowName  K �MM " M o i r a e   -   D e b u g g e rL �>�=N�> 0 kCGWindowStoreType  �= N �<�;O�< 0 kCGWindowSharingState  �; O �:�9P�: 0 kCGWindowLayer  �9  P �8�7Q�8 0 kCGWindowMemoryUsage  �7  .�`Q �6RS�6 0 kCGWindowBounds  R �5TU�5 0 X  T @f�     U �4VW�4 
0 Height  V @��     W �3XY�3 	0 Width  X @��     Y �2Z�1�2 0 Y  Z @7      �1  S �0[\�0 0 kCGWindowOwnerName  [ �]] 
 X c o d e\ �/�.�-�/ 0 kCGWindowOwnerPID  �.��-  � �,�+^�, 0 kCGWindowNumber  �+!-^ �*_`�* 0 kCGWindowAlpha  _ ?�      ` �)ab�) 0 kCGWindowName  a �cc   S i n g l e   F i l e   F i n db �(�'d�( 0 kCGWindowStoreType  �' d �&�%e�& 0 kCGWindowSharingState  �% e �$�#f�$ 0 kCGWindowLayer  �#  f �"�!g�" 0 kCGWindowMemoryUsage  �!   �`g � hi�  0 kCGWindowBounds  h �jk� 0 X  j @q`     k �lm� 
0 Height  l @f�     m �no� 	0 Width  n @�     o �p�� 0 Y  p @�     �  i �qr� 0 kCGWindowOwnerName  q �ss 
 X c o d er ���� 0 kCGWindowOwnerPID  ���  � ��t� 0 kCGWindowNumber  �!*t �uv� 0 kCGWindowAlpha  u ?�      v �wx� 0 kCGWindowName  w �yy  C o d e   A s s i s t a n tx ��z� 0 kCGWindowStoreType  � z ��{� 0 kCGWindowSharingState  � { ��|� 0 kCGWindowLayer  � e| ��}� 0 kCGWindowMemoryUsage  �`} �
~�
 0 kCGWindowBounds  ~ �	���	 0 X  � @p�     � ���� 
0 Height  � @i      � ���� 	0 Width  � @k�     � ���� 0 Y  � @|P     �   ���� 0 kCGWindowOwnerName  � ��� 
 X c o d e� ���� 0 kCGWindowOwnerPID  ���  � � ����  0 kCGWindowNumber  ��!)� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  C o d e   A s s i s t a n t� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� e� ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  � @p�     � ������ 
0 Height  � @i      � ������ 	0 Width  � @k�     � ������� 0 Y  � @|P     ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��!'� ������� 0 kCGWindowOwnerPID  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ��� * C l o t h o S c r e e n W a t c h e r . m� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  )t\� ������ 0 kCGWindowBounds  � ������ 0 X  � @�      � ������ 
0 Height  � @�P     � ������ 	0 Width  � @�x     � ������� 0 Y  � @6      ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  ��!$� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��S`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @r      � ������ 	0 Width  � @0      � ������� 0 Y  � @�      ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��!#� ������� 0 kCGWindowOwnerPID  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  C l o t h o L o g g e r . m� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  #<�� ������ 0 kCGWindowBounds  � ������ 0 X  � @      � ������ 
0 Height  � @�P     � ������ 	0 Width  � @��     � ������� 0 Y  � @6      ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  ��! � ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  �`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @�      � ������ 	0 Width  � @D�     � ������� 0 Y  � @r@     ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��!� ������� 0 kCGWindowOwnerPID  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  M o i r a e� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ��� �� 0 kCGWindowLayer  �    �~�}�~ 0 kCGWindowMemoryUsage  �}  
�� �|�| 0 kCGWindowBounds   �{�{ 0 X   @�$      �z�z 
0 Height   @}�      �y	�y 	0 Width   @u�     	 �x
�w�x 0 Y  
 @>      �w   �v�v 0 kCGWindowOwnerName   � 
 X c o d e �u�t�s�u 0 kCGWindowIsOnscreen  
�t boovtrue�s  � �r�q�r 0 kCGWindowNumber  �q� �p�o�p 0 kCGWindowOwnerPID  �o� �n�n 0 kCGWindowAlpha   ?�       �m�m 0 kCGWindowName   � D a p p l e s c r i p t   b u t t o n   -   G o o g l e   S e a r c h �l�k�l 0 kCGWindowStoreType  �k  �j�i�j 0 kCGWindowWorkspace  �i  �h�g�h 0 kCGWindowSharingState  �g  �f�e�f 0 kCGWindowLayer  �e   �d�c�d 0 kCGWindowMemoryUsage  �c  Q�� �b�b 0 kCGWindowBounds   �a�a 0 X   @��      �`�` 
0 Height   @�       �_ !�_ 	0 Width    @�      ! �^"�]�^ 0 Y  " ��8     �]   �\#$�\ 0 kCGWindowOwnerName  # �%%  S a f a r i$ �[�Z�Y�[ 0 kCGWindowIsOnscreen  
�Z boovtrue�Y  � �X�W&�X 0 kCGWindowNumber  �WA& �V'(�V 0 kCGWindowAlpha  ' ?�      ( �U)*�U 0 kCGWindowName  ) �++  F i n d* �T�S,�T 0 kCGWindowStoreType  �S , �R�Q-�R 0 kCGWindowSharingState  �Q - �P�O.�P 0 kCGWindowLayer  �O  . �N�M/�N 0 kCGWindowMemoryUsage  �M   �`/ �L01�L 0 kCGWindowBounds  0 �K23�K 0 X  2 @u�     3 �J45�J 
0 Height  4 @j      5 �I67�I 	0 Width  6 @��     7 �H8�G�H 0 Y  8 @b`     �G  1 �F9:�F 0 kCGWindowOwnerName  9 �;;  S c r i p t   E d i t o r: �E�D�C�E 0 kCGWindowOwnerPID  �D ��C  � �B�A<�B 0 kCGWindowNumber  �A}< �@�?=�@ 0 kCGWindowOwnerPID  �?�= �>>?�> 0 kCGWindowAlpha  > ?�      ? �=@A�= 0 kCGWindowName  @ �BB ` A p p l e S c r i p t   L a n g u a g e   G u i d e . p d f   ( p a g e   1 0 7   o f   4 1 5 )A �<�;C�< 0 kCGWindowStoreType  �; C �:�9D�: 0 kCGWindowWorkspace  �9 D �8�7E�8 0 kCGWindowSharingState  �7 E �6�5F�6 0 kCGWindowLayer  �5  F �4�3G�4 0 kCGWindowMemoryUsage  �3  O=�G �2HI�2 0 kCGWindowBounds  H �1JK�1 0 X  J         K �0LM�0 
0 Height  L @�P     M �/NO�/ 	0 Width  N @��     O �.P�-�. 0 Y  P @6      �-  I �,QR�, 0 kCGWindowOwnerName  Q �SS  S k i mR �+�*�)�+ 0 kCGWindowIsOnscreen  
�* boovtrue�)  � �(�'T�( 0 kCGWindowNumber  �'|T �&UV�& 0 kCGWindowAlpha  U ?�      V �%�$W�% 0 kCGWindowStoreType  �$ W �#�"X�# 0 kCGWindowSharingState  �" X �!� Y�! 0 kCGWindowLayer  �   Y ��Z� 0 kCGWindowMemoryUsage  �  S`Z �[\� 0 kCGWindowBounds  [ �]^� 0 X  ]         ^ �_`� 
0 Height  _ @p      ` �ab� 	0 Width  a @j@     b �c�� 0 Y  c @�      �  \ �de� 0 kCGWindowOwnerName  d �ff  S k i me ���� 0 kCGWindowOwnerPID  ���  � ��g� 0 kCGWindowNumber  �{g �hi� 0 kCGWindowAlpha  h ?�ff`   i �jk� 0 kCGWindowName  j �ll  k ��m� 0 kCGWindowStoreType  � m ��n� 0 kCGWindowSharingState  � n ��
o� 0 kCGWindowLayer  �
 o �	�p�	 0 kCGWindowMemoryUsage  �   �`p �qr� 0 kCGWindowBounds  q �st� 0 X  s @`�     t �uv� 
0 Height  u @^      v �wx� 	0 Width  w @y      x �y�� 0 Y  y @}      �  r �z{� 0 kCGWindowOwnerName  z �||  S k i m{ � �����  0 kCGWindowOwnerPID  �����  � ����}�� 0 kCGWindowNumber  ��x} ��~�� 0 kCGWindowAlpha  ~ ?�       ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��#`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @X      � ������ 	0 Width  � @0      � ������� 0 Y  � @�      ��  � ������ 0 kCGWindowOwnerName  � ���  S k i m� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��w� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��C`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @k      � ������ 	0 Width  � @@      � ������� 0 Y  � @�`     ��  � ������ 0 kCGWindowOwnerName  � ���  S k i m� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��v� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  #`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @�0     � ������ 	0 Width  � @@      � ������� 0 Y  � �X�     ��  � ������ 0 kCGWindowOwnerName  � ���  S k i m� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��u� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  �`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @t�     � ������ 	0 Width  � @d�     � ������� 0 Y  � @��     ��  � ������ 0 kCGWindowOwnerName  � ���  S k i m� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� g� ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  � @��     � ������ 
0 Height  � @2      � ������ 	0 Width  � @S�     � ������� 0 Y  � �rp     ��  � ������ 0 kCGWindowOwnerName  � ���  S a f a r i� �������� 0 kCGWindowOwnerPID  �����  � ������� 0 kCGWindowNumber  ��E� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @L      � ������ 	0 Width  � @4      � ������� 0 Y  � @�`     ��  � ������ 0 kCGWindowOwnerName  � ���  S a f a r i� ������� 0 kCGWindowOwnerPID  ����  � �~�}��~ 0 kCGWindowNumber  �}�� �|���| 0 kCGWindowAlpha  � ?�      � �{�z��{ 0 kCGWindowStoreType  �z � �y�x��y 0 kCGWindowSharingState  �x � �w�v��w 0 kCGWindowLayer  �v  � �u�t��u 0 kCGWindowMemoryUsage  �t`� �s���s 0 kCGWindowBounds  � �r���r 0 X  �         � �q���q 
0 Height  � @0      � �p� �p 	0 Width  � @=        �o�n�o 0 Y   @��     �n  � �m�m 0 kCGWindowOwnerName   �  S a f a r i �l�k�j�l 0 kCGWindowOwnerPID  �k��j  � �i�h�i 0 kCGWindowNumber  �h� �g�g 0 kCGWindowAlpha   ?�       �f�e�f 0 kCGWindowStoreType  �e  �d�c	�d 0 kCGWindowSharingState  �c 	 �b�a
�b 0 kCGWindowLayer  �a  
 �`�_�` 0 kCGWindowMemoryUsage  �_   �` �^�^ 0 kCGWindowBounds   �]�] 0 X            �\�\ 
0 Height   @��      �[�[ 	0 Width   @0       �Z�Y�Z 0 Y   @q@     �Y   �X�X 0 kCGWindowOwnerName   �  S a f a r i �W�V�U�W 0 kCGWindowOwnerPID  �V��U  � �T�S�T 0 kCGWindowNumber  �S� �R�R 0 kCGWindowAlpha   ?�       �Q�Q 0 kCGWindowName   �   �P�O�P 0 kCGWindowStoreType  �O  �N�M�N 0 kCGWindowSharingState  �M  �L�K �L 0 kCGWindowLayer  �K    �J�I!�J 0 kCGWindowMemoryUsage  �I  3`! �H"#�H 0 kCGWindowBounds  " �G$%�G 0 X  $ @�     % �F&'�F 
0 Height  & @p�     ' �E()�E 	0 Width  ( @w0     ) �D*�C�D 0 Y  * @R�     �C  # �B+,�B 0 kCGWindowOwnerName  + �--  S a f a r i, �A�@�?�A 0 kCGWindowOwnerPID  �@��?  � �>�=.�> 0 kCGWindowNumber  �=	. �</0�< 0 kCGWindowAlpha  / ?�      0 �;�:1�; 0 kCGWindowStoreType  �: 1 �9�82�9 0 kCGWindowSharingState  �8 2 �7�63�7 0 kCGWindowLayer  �6  3 �5�44�5 0 kCGWindowMemoryUsage  �4#`4 �356�3 0 kCGWindowBounds  5 �278�2 0 X  7         8 �19:�1 
0 Height  9 @a      : �0;<�0 	0 Width  ; @0      < �/=�.�/ 0 Y  = @��     �.  6 �->?�- 0 kCGWindowOwnerName  > �@@  M a i l? �,�+�*�, 0 kCGWindowOwnerPID  �+��*  � �)�(A�) 0 kCGWindowNumber  �(�A �'�&B�' 0 kCGWindowOwnerPID  �&�B �%CD�% 0 kCGWindowAlpha  C ?�      D �$EF�$ 0 kCGWindowName  E �GG * I n b o x   ( 5 7 7 8   m e s s a g e s )F �#�"H�# 0 kCGWindowStoreType  �" H �!� I�! 0 kCGWindowWorkspace  �  I ��J� 0 kCGWindowSharingState  � J ��K� 0 kCGWindowLayer  �  K ��L� 0 kCGWindowMemoryUsage  �  A?�L �MN� 0 kCGWindowBounds  M �OP� 0 X  O @��     P �QR� 
0 Height  Q @�      R �ST� 	0 Width  S @��     T �U�� 0 Y  U ��8     �  N �VW� 0 kCGWindowOwnerName  V �XX  M a i lW ���� 0 kCGWindowIsOnscreen  
� boovtrue�  � ��Y� 0 kCGWindowNumber  ��Y �Z[� 0 kCGWindowAlpha  Z ?�      [ ��\� 0 kCGWindowStoreType  � \ �
�	]�
 0 kCGWindowSharingState  �	 ] ��^� 0 kCGWindowLayer  �  ^ ��_� 0 kCGWindowMemoryUsage  �  �`_ �`a� 0 kCGWindowBounds  ` �bc� 0 X  b @y      c �de� 
0 Height  d @``     e �fg� 	0 Width  f @z@     g � h���  0 Y  h @Y      ��  a ��ij�� 0 kCGWindowOwnerName  i �kk  S c r i p t   E d i t o rj �������� 0 kCGWindowOwnerPID  �� ���  � ����l�� 0 kCGWindowNumber  ���l ����m�� 0 kCGWindowOwnerPID  �� �m ��no�� 0 kCGWindowAlpha  n ?�      o ��pq�� 0 kCGWindowName  p �rr  p L i s t   5 0 0 0q ����s�� 0 kCGWindowStoreType  �� s ����t�� 0 kCGWindowWorkspace  �� t ����u�� 0 kCGWindowSharingState  �� u ����v�� 0 kCGWindowLayer  ��  v ����w�� 0 kCGWindowMemoryUsage  ��  \w ��xy�� 0 kCGWindowBounds  x ��z{�� 0 X  z @vP     { ��|}�� 
0 Height  | @�8     } ��~�� 	0 Width  ~ @�      ������� 0 Y  � @6      ��  y ������ 0 kCGWindowOwnerName  � ���  S c r i p t   E d i t o r� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� e� ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  � @p�     � ������ 
0 Height  � @i      � ������ 	0 Width  � @k�     � ������� 0 Y  � @|P     ��  � ������ 0 kCGWindowOwnerName  � ���  S c r i p t   E d i t o r� �������� 0 kCGWindowOwnerPID  �� ���  � ������� 0 kCGWindowNumber  �� �� ������� 0 kCGWindowOwnerPID  �� �� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� � ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  � @�8     � ������ 
0 Height  � @6      � ������ 	0 Width  � @8      � ������� 0 Y  �         ��  � ������ 0 kCGWindowOwnerName  � ���  D r o p b o x� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  �� ~� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ��� & D r o p b o x   P r e f e r e n c e s� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��`� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @o@     � ������ 	0 Width  � @y      � ������� 0 Y  � @6      ��  � ������ 0 kCGWindowOwnerName  � ���  D r o p b o x� �������� 0 kCGWindowOwnerPID  �� ���  � ������� 0 kCGWindowNumber  �� !� ������� 0 kCGWindowOwnerPID  �� �� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� � ������� 0 kCGWindowMemoryUsage  ��#`� ������ 0 kCGWindowBounds  � ������ 0 X  � @��     � ������ 
0 Height  � @6      � ������ 	0 Width  � @A      � ������� 0 Y  �         ��  � ������ 0 kCGWindowOwnerName  � ���  C a f f e i n e� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ����� 	� 	 ���������� ������� 0 kCGWindowNumber  �� !� ������� 0 kCGWindowOwnerPID  �� �� ���� 0 kCGWindowAlpha  � ?�      � �~���~ 0 kCGWindowName  � ���  � �}�|��} 0 kCGWindowStoreType  �| � �{�z��{ 0 kCGWindowSharingState  �z � �y�x��y 0 kCGWindowLayer  �x � �w�v��w 0 kCGWindowMemoryUsage  �v#`� �u���u 0 kCGWindowBounds  � �t���t 0 X  � @��     � �s���s 
0 Height  � @6      � �r���r 	0 Width  � @A      � �q��p�q 0 Y  �         �p  � �o���o 0 kCGWindowOwnerName  � ���  C a f f e i n e� �n�m�l�n 0 kCGWindowIsOnscreen  
�m boovtrue�l  � �k�j��k 0 kCGWindowNumber  �j �� �i�h �i 0 kCGWindowOwnerPID  �h �  �g�g 0 kCGWindowAlpha   ?�       �f�f 0 kCGWindowName   �   �e�d�e 0 kCGWindowStoreType  �d  �c�b�c 0 kCGWindowSharingState  �b  �a�`�a 0 kCGWindowLayer  �`  �_�^	�_ 0 kCGWindowMemoryUsage  �^`	 �]
�] 0 kCGWindowBounds  
 �\�\ 0 X   @�8      �[�[ 
0 Height   @6       �Z�Z 	0 Width   @8       �Y�X�Y 0 Y           �X   �W�W 0 kCGWindowOwnerName   �  D r o p b o x �V�U�T�V 0 kCGWindowIsOnscreen  
�U boovtrue�T  � �S�R�S 0 kCGWindowNumber  �R!' �Q�P�Q 0 kCGWindowOwnerPID  �P� �O�O 0 kCGWindowAlpha   ?�       �N�N 0 kCGWindowName   � * C l o t h o S c r e e n W a t c h e r . m �M�L�M 0 kCGWindowStoreType  �L  �K�J�K 0 kCGWindowWorkspace  �J  �I�H�I 0 kCGWindowSharingState  �H  �G�F �G 0 kCGWindowLayer  �F    �E�D!�E 0 kCGWindowMemoryUsage  �D  )t\! �C"#�C 0 kCGWindowBounds  " �B$%�B 0 X  $ @�      % �A&'�A 
0 Height  & @�P     ' �@()�@ 	0 Width  ( @�x     ) �?*�>�? 0 Y  * @6      �>  # �=+,�= 0 kCGWindowOwnerName  + �-- 
 X c o d e, �<�;�:�< 0 kCGWindowIsOnscreen  
�; boovtrue�:  � �9�8.�9 0 kCGWindowNumber  �8!#. �7�6/�7 0 kCGWindowOwnerPID  �6�/ �501�5 0 kCGWindowAlpha  0 ?�      1 �423�4 0 kCGWindowName  2 �44  C l o t h o L o g g e r . m3 �3�25�3 0 kCGWindowStoreType  �2 5 �1�06�1 0 kCGWindowWorkspace  �0 6 �/�.7�/ 0 kCGWindowSharingState  �. 7 �-�,8�- 0 kCGWindowLayer  �,  8 �+�*9�+ 0 kCGWindowMemoryUsage  �*  #<�9 �):;�) 0 kCGWindowBounds  : �(<=�( 0 X  < @      = �'>?�' 
0 Height  > @�P     ? �&@A�& 	0 Width  @ @��     A �%B�$�% 0 Y  B @6      �$  ; �#CD�# 0 kCGWindowOwnerName  C �EE 
 X c o d eD �"�!� �" 0 kCGWindowIsOnscreen  
�! boovtrue�   � ��F� 0 kCGWindowNumber  �!F ��G� 0 kCGWindowOwnerPID  ��G �HI� 0 kCGWindowAlpha  H ?�      I �JK� 0 kCGWindowName  J �LL  M o i r a eK ��M� 0 kCGWindowStoreType  � M ��N� 0 kCGWindowWorkspace  � N ��O� 0 kCGWindowSharingState  � O ��P� 0 kCGWindowLayer  �  P ��Q� 0 kCGWindowMemoryUsage  �  
��Q �RS� 0 kCGWindowBounds  R �TU� 0 X  T @�$     U �VW� 
0 Height  V @}�     W �XY� 	0 Width  X @u�     Y �Z�
� 0 Y  Z @>      �
  S �	[\�	 0 kCGWindowOwnerName  [ �]] 
 X c o d e\ ���� 0 kCGWindowIsOnscreen  
� boovtrue�  � ��^� 0 kCGWindowNumber  ��^ ��_� 0 kCGWindowOwnerPID  � �_ �`a� 0 kCGWindowAlpha  ` ?�      a � bc�  0 kCGWindowName  b �dd  p L i s t   5 0 0 0c ����e�� 0 kCGWindowStoreType  �� e ����f�� 0 kCGWindowWorkspace  �� f ����g�� 0 kCGWindowSharingState  �� g ����h�� 0 kCGWindowLayer  ��  h ����i�� 0 kCGWindowMemoryUsage  ��  \i ��jk�� 0 kCGWindowBounds  j ��lm�� 0 X  l @vP     m ��no�� 
0 Height  n @�8     o ��pq�� 	0 Width  p @�     q ��r���� 0 Y  r @6      ��  k ��st�� 0 kCGWindowOwnerName  s �uu  S c r i p t   E d i t o rt �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ����v�� 0 kCGWindowNumber  ��}v ����w�� 0 kCGWindowOwnerPID  ���w ��xy�� 0 kCGWindowAlpha  x ?�      y ��z{�� 0 kCGWindowName  z �|| ` A p p l e S c r i p t   L a n g u a g e   G u i d e . p d f   ( p a g e   1 0 7   o f   4 1 5 ){ ����}�� 0 kCGWindowStoreType  �� } ����~�� 0 kCGWindowWorkspace  �� ~ ������ 0 kCGWindowSharingState  ��  ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  O=�� ������ 0 kCGWindowBounds  � ������ 0 X  �         � ������ 
0 Height  � @�P     � ������ 	0 Width  � @��     � ������� 0 Y  � @6      ��  � ������ 0 kCGWindowOwnerName  � ���  S k i m� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  ���� ������� 0 kCGWindowOwnerPID  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ��� D a p p l e s c r i p t   b u t t o n   -   G o o g l e   S e a r c h� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  Q��� ������ 0 kCGWindowBounds  � ������ 0 X  � @��     � ������ 
0 Height  � @�      � ������ 	0 Width  � @�      � ������� 0 Y  � ��8     ��  � ������ 0 kCGWindowOwnerName  � ���  S a f a r i� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  � ������� 0 kCGWindowNumber  ���� ������� 0 kCGWindowOwnerPID  ���� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ��� * I n b o x   ( 5 7 7 8   m e s s a g e s )� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  A?�� ������ 0 kCGWindowBounds  � ������ 0 X  � @��     � ������ 
0 Height  � @�      � ������ 	0 Width  � @��     � ������� 0 Y  � ��8     ��  � ������ 0 kCGWindowOwnerName  � ���  M a i l� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  �� !�� ���  ��  ��  ��  ��   ascr  ��ޭ