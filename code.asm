#=====================================
# 				MEMORY
# ballPosX: FB
# ballPosY: FC
# vX: 		FD
# vY: 		FE
# rightBatY:FF
#=====================================
asect 0x00

start:
	ldi r1,15
	ldi r2,rightBatY
	st r2,r1
	br main
main:

ldi r0,vX
ld r0,r0

ldi r1,ballPosX
ld r1,r1

ldi r2,15

if
	cmp r1,r2	#right side?	
is gt	#right side
	if
		tst r0		# vX>0?
	is pl	
						
		ldi r0,vY
		ld r0,r0
			
		ldi r2,31		
		ldi r3,28
			
		if
			tst r0		# vY>0?
		is pl 			# we're moving up
			ldi r0,ballPosY
			ld r0,r0
				
			ldi r1,ballPosX
			ld r1,r1
				
			sub r3,r1	# 28-x
			add r0,r1	# (28-x)+y
				
			if
				cmp r1,	r2	# (28-x)+y>31?
			is gt 		# reflection on the ceiling
				sub r1,r0
				ld r1,r0 
				dec r1
			else  		# no reflection
				dec r1
			fi
		else			# we're moving down
			ldi r0,ballPosY
			ld r0,r0
				
			ldi r1,ballPosX
			ld r1,r1
				
			ldi r2, 0
			ldi r3,28
				
			sub r3,r1 # 28-x
			
			if
				cmp r0,r1 # y <(28-x)?
			is lt 		# reflection on the floor
				sub r1,r0 # (28-x)-y
				ld r1,r0
				dec r1
			else  		# no reflection
				sub r0,r1 # y-(28-x)
				dec r1
			fi
		fi
			
		ldi r3, 0
		if
			cmp r1,r3 # rightBatY<0?
		is lt
			ldi r1, 0
		else
			ldi r3, 29
			if
				cmp r1,r3 #rightBatY>29?
			is gt
				ldi r1, 29
			fi
		fi
			
		ldi r2,rightBatY
		ld r2,r2
		if
			cmp r1,r2
		is gt		# the right bat is moving up
			ldi r0,rightBatY
			while
				cmp r1,r2
			stays gt
				inc r2
				st r0,r2
			wend
		else		# the right bat is moving down
			ldi r0,rightBatY
			while
				cmp r1,r2
			stays lt			
				dec r2
				st r0,r2
			wend
		fi
		
		ldi r1,ballPosX
		ld r1,r1
		ldi r2, 29 
		if 
			cmp r1, r2
		is gt			# goal
			ldi r1,15
			ldi r2,rightBatY
			st r2,r1
		fi
	fi
else #left side
	ldi r2, 2 
	if 
		cmp r1, r2
	is lt			# goal
		ldi r1,15
		ldi r2,rightBatY
		st r2,r1
	fi
fi
br main



	asect 0xfb
ballPosX:
	asect 0xfc
ballPosY:
	asect 0xfd
vX: 
	asect 0xfe
vY: 
	asect 0xff
rightBatY:


end
