FasdUAS 1.101.10   ��   ��    k             i         I     ������
�� .aevtoappnull  �   � ****��  ��    k     	 	  
  
 l     ��  ��    J D create path to System_Snapshots folder and choose the file to check     �   �   c r e a t e   p a t h   t o   S y s t e m _ S n a p s h o t s   f o l d e r   a n d   c h o o s e   t h e   f i l e   t o   c h e c k      r         n         1   
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
chosenFile      l   ��������  ��  ��        l   ��   ��      create file to write to      � ! ! 0   c r e a t e   f i l e   t o   w r i t e   t o   " # " r     $ % $ 4    �� &
�� 
psxf & m     ' ' � ( ( 2 / U s e r s / J C / D e s k t o p / l o g . t x t % o      ���� 0 	writefile 	writeFile #  ) * ) Q    = + , - + k    $ . .  / 0 / r    " 1 2 1 I    �� 3 4
�� .rdwropenshor       file 3 o    ���� 0 	writefile 	writeFile 4 �� 5��
�� 
perm 5 m    ��
�� boovtrue��   2 o      ���� 0 	writefile 	writeFile 0  6�� 6 l  # #�� 7 8��   7   display dialog "Success"    8 � 9 9 2   d i s p l a y   d i a l o g   " S u c c e s s "��   , R      ������
�� .ascrerr ****      � ****��  ��   - Q   , = : ;�� : k   / 4 < <  = > = l  / /�� ? @��   ?  display dialog "Fail"    @ � A A * d i s p l a y   d i a l o g   " F a i l " >  B�� B I  / 4�� C��
�� .rdwrclosnull���     **** C o   / 0���� 0 	writefile 	writeFile��  ��   ; R      ������
�� .ascrerr ****      � ****��  ��  ��   *  D E D l  > >��������  ��  ��   E  F G F l  > >��������  ��  ��   G  H I H l  > >��������  ��  ��   I  J K J l  > >��������  ��  ��   K  L�� L O   > M N M k   B  O O  P Q P I  B c�� R S
�� .rdwrwritnull���     **** R l  B M T���� T b   B M U V U l  B I W���� W n   B I X Y X 1   G I��
�� 
dstr Y l  B G Z���� Z l  B G [���� [ I  B G������
�� .misccurdldt    ��� null��  ��  ��  ��  ��  ��  ��  ��   V o   I L��
�� 
ret ��  ��   S �� \ ]
�� 
refn \ o   P Q���� 0 	writefile 	writeFile ] �� ^ _
�� 
wrat ^ m   T W��
�� rdwreof  _ �� `��
�� 
as   ` m   Z ]��
�� 
TEXT��   Q  a b a I  d ��� c d
�� .rdwrwritnull���     **** c b   d m e f e l  d i g���� g c   d i h i h o   d e���� 0 
chosenfile 
chosenFile i m   e h��
�� 
TEXT��  ��   f o   i l��
�� 
ret  d �� j k
�� 
refn j o   p q���� 0 	writefile 	writeFile k �� l m
�� 
wrat l m   t w��
�� rdwreof  m �� n��
�� 
as   n m   z }��
�� 
TEXT��   b  o p o l  � ��� q r��   q 6 0 read in the contents of the selected plist file    r � s s `   r e a d   i n   t h e   c o n t e n t s   o f   t h e   s e l e c t e d   p l i s t   f i l e p  t u t r   � � v w v l  � � x���� x n   � � y z y 1   � ���
�� 
pcnt z 4   � ��� {
�� 
plif { o   � ����� 0 
chosenfile 
chosenFile��  ��   w o      ���� 0 thedata theData u  |�� | O   �  } ~ } k   ��    � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   read in OptionAll data    � � � � .   r e a d   i n   O p t i o n A l l   d a t a �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 2  � ���
�� 
plii � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� 0 optionalllist optionAllList �  � � � r   � � � � � J   � �����   � o      ���� 0 optallwinnum optAllWinNum �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � ) # read in OptionAll kCGWindowNumbers    � � � � F   r e a d   i n   O p t i o n A l l   k C G W i n d o w N u m b e r s �  � � � I  � ��� � �
�� .rdwrwritnull���     **** � l  � � ����� � b   � � � � � m   � � � � � � �   - - - O p t i o n   A l l - - - � o   � ���
�� 
ret ��  ��   � �� � �
�� 
refn � o   � ����� 0 	writefile 	writeFile � �� ���
�� 
wrat � m   � ���
�� rdwreof ��   �  � � � I  � ��� � �
�� .rdwrwritnull���     **** � l  � � ����� � b   � � � � � l  � � ����� � c   � � � � � b   � � � � � m   � � � � � � � * o p t i o n A l l L i s t   c o u n t :   � l  � � ����� � I  � �� ��~
� .corecnte****       **** � o   � ��}�} 0 optionalllist optionAllList�~  ��  ��   � m   � ��|
�| 
TEXT��  ��   � o   � ��{
�{ 
ret ��  ��   � �z � �
�z 
refn � o   � ��y�y 0 	writefile 	writeFile � �x � �
�x 
wrat � m   � ��w
�w rdwreof  � �v ��u
�v 
as   � m   � ��t
�t 
TEXT�u   �  � � � Y   �b ��s � ��r � k  ] � �  � � � r  - � � � n  ) � � � 1  %)�q
�q 
valL � n  % � � � 4  %�p �
�p 
plii � m  !$ � � � � �  k C G W i n d o w N u m b e r � n   � � � 4  �o �
�o 
plii � o  �n�n 0 thecount theCount � n   � � � 4  �m �
�m 
plii � m  �l�l  � 4  �k �
�k 
plii � m  �j�j  � o      �i�i 0 windownumber windowNumber �  � � � I .O�h � �
�h .rdwrwritnull���     **** � b  .9 � � � l .5 ��g�f � c  .5 � � � o  .1�e�e 0 windownumber windowNumber � m  14�d
�d 
TEXT�g  �f   � m  58 � � � � �    � �c � �
�c 
refn � o  <=�b�b 0 	writefile 	writeFile � �a � �
�a 
wrat � m  @C�`
�` rdwreof  � �_ ��^
�_ 
as   � m  FI�]
�] 
TEXT�^   �  ��\ � r  P] � � � b  PY � � � o  PS�[�[ 0 optallwinnum optAllWinNum � J  SX � �  ��Z � o  SV�Y�Y 0 windownumber windowNumber�Z   � o      �X�X 0 optallwinnum optAllWinNum�\  �s 0 thecount theCount � m  �W�W  � I 	�V ��U
�V .corecnte****       **** � o  �T�T 0 optionalllist optionAllList�U  �r   �  � � � I cz�S � �
�S .rdwrwritnull���     **** � b  cj � � � o  cf�R
�R 
ret  � m  fi � � � � �   w i n d o w   n u m b e r s :   � �Q � �
�Q 
refn � o  mn�P�P 0 	writefile 	writeFile � �O ��N
�O 
wrat � m  qt�M
�M rdwreof �N   �  � � � l {{�L�K�J�L  �K  �J   �  � � � l {{�I � ��I   � &   read in OptionOnScreenOnly data    � �   @   r e a d   i n   O p t i o n O n S c r e e n O n l y   d a t a �  r  {� l {��H�G n  {� 1  ���F
�F 
valL n  {�	 2 ���E
�E 
plii	 n  {�

 4  ���D
�D 
plii m  ���C�C  4  {��B
�B 
plii m  ��A�A �H  �G   o      �@�@ "0 optonscreenlist optOnScreenList  r  �� J  ���?�?   o      �>�> 0 optonscrnum optOnScrNum  l ���=�<�;�=  �<  �;    l ���:�:   2 , read in OptionOnScreenOnly kCGWindowNumbers    � X   r e a d   i n   O p t i o n O n S c r e e n O n l y   k C G W i n d o w N u m b e r s  I ���9
�9 .rdwrwritnull���     **** l ���8�7 b  �� m  ��   �!! 6 - - - O p t i o n   O n   S c r e e n   O n l y - - - o  ���6
�6 
ret �8  �7   �5"#
�5 
refn" o  ���4�4 0 	writefile 	writeFile# �3$%
�3 
wrat$ m  ���2
�2 rdwreof % �1&�0
�1 
as  & m  ���/
�/ 
TEXT�0   '(' I ���.)*
�. .rdwrwritnull���     ****) l ��+�-�,+ b  ��,-, b  ��./. b  ��010 m  ��22 �33 , o p t i o n O n S c r e e n   c o u n t :  1 l ��4�+�*4 c  ��565 l ��7�)�(7 I ���'8�&
�' .corecnte****       ****8 o  ���%�% "0 optonscreenlist optOnScreenList�&  �)  �(  6 m  ���$
�$ 
TEXT�+  �*  / o  ���#
�# 
ret - m  ��99 �::   w i n d o w   n u m b e r s :  �-  �,  * �";<
�" 
refn; o  ���!�! 0 	writefile 	writeFile< � =>
�  
wrat= m  ���
� rdwreof > �?�
� 
as  ? m  ���
� 
TEXT�  ( @A@ Y  �JB�CD�B k  �EEE FGF r  �HIH n  �JKJ 1  �
� 
valLK n  �LML 4  �N
� 
pliiN m  	OO �PP  k C G W i n d o w N u m b e rM n  �QRQ 4  �S
� 
pliiS o  �� 0 thecount theCountR n  �TUT 4  ��V
� 
pliiV m  � �� U 4  ���W
� 
pliiW m  ���� I o      �� 0 windownumber windowNumberG XYX r  #Z[Z b  \]\ o  �� 0 optonscrnum optOnScrNum] J  ^^ _�_ o  �� 0 windownumber windowNumber�  [ o      �� 0 optonscrnum optOnScrNumY `�` I $E�ab
� .rdwrwritnull���     ****a l $/c�
�	c b  $/ded l $+f��f c  $+ghg o  $'�� 0 windownumber windowNumberh m  '*�
� 
TEXT�  �  e m  +.ii �jj   �
  �	  b �kl
� 
refnk o  23�� 0 	writefile 	writeFilel �mn
� 
wratm m  69�
� rdwreof n � o��
�  
as  o m  <?��
�� 
TEXT��  �  � 0 thecount theCountC m  ������ D l ��p����p I ����q��
�� .corecnte****       ****q o  ������ "0 optonscreenlist optOnScreenList��  ��  ��  �  A rsr l KK��������  ��  ��  s tut l KK��vw��  v F @ compare onScreenOnly window numbers to optionAll window numbers   w �xx �   c o m p a r e   o n S c r e e n O n l y   w i n d o w   n u m b e r s   t o   o p t i o n A l l   w i n d o w   n u m b e r su yzy r  KQ{|{ J  KM����  | o      ���� 0 disaster  z }~} X  R���� k  h��� ��� Z  h�������� H  hn�� E  hm��� o  hk���� 0 optallwinnum optAllWinNum� o  kl���� 0 winnumon winNumOn� r  q���� b  q���� o  qt���� 0 disaster  � J  t�� ���� c  t}��� b  ty��� m  tw�� ��� .   O h   n o ,   w e   N O T   c o o l ! ! !  � o  wx���� 0 winnumon winNumOn� m  y|��
�� 
TEXT��  � o      ���� 0 disaster  ��  ��  � ���� l ����������  ��  ��  ��  �� 0 winnumon winNumOn� o  UX���� 0 optonscrnum optOnScrNum~ ��� l ����������  ��  ��  � ��� Z  ��������� ?  ����� l �������� I �������
�� .corecnte****       ****� o  ������ 0 disaster  ��  ��  ��  � m  ������  � I �������
�� .sysodlogaskr        TEXT� m  ���� ���  S h i t . . .��  ��  ��  � ��� I ������
�� .rdwrwritnull���     ****� o  ����
�� 
ret � ����
�� 
refn� o  ������ 0 	writefile 	writeFile� �����
�� 
wrat� m  ����
�� rdwreof ��  � ��� I ������
�� .rdwrwritnull���     ****� l �������� b  ����� b  ����� m  ���� ���  D i s a s t e r :  � l �������� c  ����� o  ������ 0 disaster  � m  ����
�� 
TEXT��  ��  � o  ����
�� 
ret ��  ��  � ����
�� 
refn� o  ������ 0 	writefile 	writeFile� ����
�� 
wrat� m  ����
�� rdwreof � �����
�� 
as  � m  ����
�� 
TEXT��  � ���� I ������
�� .rdwrwritnull���     ****� b  ����� m  ���� ��� 2 = = = = = = = = = = = = = = = = = = = = = = = = =� o  ����
�� 
ret � ����
�� 
refn� o  ������ 0 	writefile 	writeFile� ����
�� 
wrat� m  ����
�� rdwreof � �����
�� 
as  � m  ����
�� 
TEXT��  ��   ~ n   � ���� 1   � ���
�� 
pcnt� o   � ����� 0 thedata theData��   N m   > ?���                                                                                  sevs   alis    �  Macintosh HD               �a�H+     tSystem Events.app                                                ����        ����  	                CoreServices    �bu      ��C       t   0   /  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��    ���� l     ��������  ��  ��  ��       ������  � ��
�� .aevtoappnull  �   � ****� �� ��������
�� .aevtoappnull  �   � ****��  ��  � ������ 0 thecount theCount�� 0 winnumon winNumOn� 6���� ������ '����������������������������������������������� ��� ��� ��� � ����� 29Oi������������
�� 
dflc
�� 
psxf
�� .sysostdfalis    ��� null
�� 
psxp�� 0 
chosenfile 
chosenFile�� 0 	writefile 	writeFile
�� 
perm
�� .rdwropenshor       file��  ��  
�� .rdwrclosnull���     ****
�� .misccurdldt    ��� null
�� 
dstr
�� 
ret 
�� 
refn
�� 
wrat
�� rdwreof 
�� 
as  
�� 
TEXT�� 
�� .rdwrwritnull���     ****
�� 
plif
�� 
pcnt�� 0 thedata theData
�� 
plii
�� 
valL�� 0 optionalllist optionAllList�� 0 optallwinnum optAllWinNum�� 
�� .corecnte****       ****�� 0 windownumber windowNumber�� "0 optonscreenlist optOnScreenList�� 0 optonscrnum optOnScrNum�� 0 disaster  
�� 
kocl
�� 
cobj
�� .sysodlogaskr        TEXT��*�)��/l �,E�O)��/E�O ��el 	E�OPW X 
  
�j W X 
 hO��*j �,_ %a �a a a a a  O�a &_ %a �a a a a a  O*a �/a ,E` O_ a ,d*a k/a k/a -a ,E` OjvE` Oa _ %a �a a a   Oa !_ j "%a &_ %a �a a a a a  O ck_ j "kh  *a k/a k/a �/a a #/a ,E` $O_ $a &a %%a �a a a a a  O_ _ $kv%E` [OY��O_ a &%a �a a a   O*a l/a k/a -a ,E` 'OjvE` (Oa )_ %a �a a a a a  Oa *_ 'j "a &%_ %a +%a �a a a a a  O ck_ 'j "kh  *a l/a k/a �/a a ,/a ,E` $O_ (_ $kv%E` (O_ $a &a -%a �a a a a a  [OY��OjvE` .O <_ ([a /a 0l "kh _ � _ .a 1�%a &kv%E` .Y hOP[OY��O_ .j "j a 2j 3Y hO_ a �a a a   Oa 4_ .a &%_ %a �a a a a a  Oa 5_ %a �a a a a a  UU ascr  ��ޭ