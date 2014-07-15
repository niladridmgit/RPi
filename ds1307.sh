#!/bin/sh

case $1 in

 	"set" )
		case $2 in
		"" )	se=`date | tr -d '\r\n' | cut -b 37-38`
			xse=0x$se ; echo $se
			mi=`date | tr -d '\r\n' | cut -b 34-35`
        		xmi=0x$mi ; echo $mi
			ho=`date | tr -d '\r\n' | cut -b 31-32`
        		xho=0x$ho ; echo $ho
			we=`date | tr -d '\r\n' | cut -b 37-38`
	        	xwe=0x$we ; echo $we
			da=`date | tr -d '\r\n' | cut -b 15-16 | tr -d ' '`
                        if [ `echo ${#da}` -lt 2 ]
                        then
                                xda=0x0$da
                        else
                                xda=0x$da
                        fi ; echo $da
			mo=`date | tr -d '\r\n' | cut -b 9-10 | tr -d ' '`
        		if [ `echo ${#mo}` -lt 2 ]
        		then
 	       		        xmo=0x0$mo
        		else
        		        xda=0x$mo
        		fi ; echo $mo
			ye=`date | tr -d '\r\n' | cut -b 3-4`
	        	xye=0x$ye ; echo $ye
	
			sudo i2cset -y 1 0x68 0x00 $xse ; echo $xse
			sudo i2cset -y 1 0x68 0x01 $xmi ; echo $xmi
			sudo i2cset -y 1 0x68 0x02 $xho ; echo $xho
			sudo i2cset -y 1 0x68 0x03 $xwe ; echo $xwe
			sudo i2cset -y 1 0x68 0x04 $xda ; echo $xda
			sudo i2cset -y 1 0x68 0x05 $xmo ; echo $xmo
			sudo i2cset -y 1 0x68 0x06 $xye ; echo $xye
	
			date
			./ds1307.sh ;;

		"se" )	sudo i2cset -y 1 0x68 0x00 0x$3 ;;
		"mi" ) 	sudo i2cset -y 1 0x68 0x01 0x$3 ;;
		"ho" )  sudo i2cset -y 1 0x68 0x02 0x$3 ;;
		"we" ) 	sudo i2cset -y 1 0x68 0x03 0x$3 ;;
		"da" ) 	sudo i2cset -y 1 0x68 0x04 0x$3 ;;
		"mo" ) 	sudo i2cset -y 1 0x68 0x05 0x$3 ;;
		"ye" )	sudo i2cset -y 1 0x68 0x06 0x$3 ;;

		esac ;;
	
	"" )	se=`sudo i2cget -y 1 0x68 0x00 | tr -d '\r\n' | cut -b 3-4`
		mi=`sudo i2cget -y 1 0x68 0x01 | tr -d '\r\n' | cut -b 3-4`
		ho=`sudo i2cget -y 1 0x68 0x02 | tr -d '\r\n' | cut -b 3-4`
		we=`sudo i2cget -y 1 0x68 0x03 | tr -d '\r\n' | cut -b 3-4`
		da=`sudo i2cget -y 1 0x68 0x04 | tr -d '\r\n' | cut -b 3-4`
		mo=`sudo i2cget -y 1 0x68 0x05 | tr -d '\r\n' | cut -b 3-4`
		ye=`sudo i2cget -y 1 0x68 0x06 | tr -d '\r\n' | cut -b 3-4`
		
		echo 20$ye $mo-$da $we $ho:$mi:$se;;
	esac	
