#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     16                         ;# number of mobilenodes
set val(rp)     DSDV                      ;# routing protocol
set val(x)      1400                      ;# X dimension of topography
set val(y)      901                      ;# Y dimension of topography
set val(stop)   250.0 

# Trace set show_sctphdr_ 1
#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open code.tr w]
$ns trace-all $tracefile
$ns use-newtrace

#Open the NAM trace file
set namfile [open code.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -energyModel "EnergyModel" \
		        -initialEnergy 100.0 \
			    -txPower 0.9 \
			    -rxPower 0.4 \
			    -idlePower 0.1 \
		        -sleepPower 0.1 \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
array set n {}
#Create 16 nodes
set n(0) [$ns node]
$n(0) set X_ 602
$n(0) set Y_ 601
$n(0) set Z_ 0.0
$ns initial_node_pos $n(0) 20
set n(1) [$ns node]
$n(1) set X_ 599
$n(1) set Y_ 505
$n(1) set Z_ 0.0
$ns initial_node_pos $n(1) 20
set n(2) [$ns node]
$n(2) set X_ 646
$n(2) set Y_ 452
$n(2) set Z_ 0.0
$ns initial_node_pos $n(2) 20
set n(3) [$ns node]
$n(3) set X_ 698
$n(3) set Y_ 502
$n(3) set Z_ 0.0
$ns initial_node_pos $n(3) 20
set n(4) [$ns node]
$n(4) set X_ 700
$n(4) set Y_ 602
$n(4) set Z_ 0.0
$ns initial_node_pos $n(4) 20
set n(5) [$ns node]
$n(5) set X_ 767
$n(5) set Y_ 557
$n(5) set Z_ 0.0
$ns initial_node_pos $n(5) 20
set n(6) [$ns node]
$n(6) set X_ 747
$n(6) set Y_ 455
$n(6) set Z_ 0.0
$ns initial_node_pos $n(6) 20
set n(7) [$ns node]
$n(7) set X_ 654
$n(7) set Y_ 406
$n(7) set Z_ 0.0
$ns initial_node_pos $n(7) 20
set n(8) [$ns node]
$n(8) set X_ 701
$n(8) set Y_ 392
$n(8) set Z_ 0.0
$ns initial_node_pos $n(8) 20
set n(9) [$ns node]
$n(9) set X_ 745
$n(9) set Y_ 402
$n(9) set Z_ 0.0
$ns initial_node_pos $n(9) 20
set n(10) [$ns node]
$n(10) set X_ 795
$n(10) set Y_ 437
$n(10) set Z_ 0.0
$ns initial_node_pos $n(10) 20
set n(11) [$ns node]
$n(11) set X_ 801
$n(11) set Y_ 487
$n(11) set Z_ 0.0
$ns initial_node_pos $n(11) 20
set n(12) [$ns node]
$n(12) set X_ 812
$n(12) set Y_ 543
$n(12) set Z_ 0.0
$ns initial_node_pos $n(12) 20
set n(13) [$ns node]
$n(13) set X_ 777
$n(13) set Y_ 599
$n(13) set Z_ 0.0
$ns initial_node_pos $n(13) 20
set n(14) [$ns node]
$n(14) set X_ 593
$n(14) set Y_ 432
$n(14) set Z_ 0.0
$ns initial_node_pos $n(14) 20
set n(15) [$ns node]
$n(15) set X_ 730
$n(15) set Y_ 635
$n(15) set Z_ 0.0
$ns initial_node_pos $n(15) 20



#===================================
#        Nodes movment       
#===================================
# $ns at 0.3 " $n(0) setdest 600 600 10 " 
# $ns at 0.5 " $n(1) setdest 700 500 20 " 

#===================================
#       Energy sets
#===================================

set energylist(0) 100
set energylist(1) 100
set energylist(2) 100
set energylist(3) 100
set energylist(4) 100
set energylist(5) 100
set energylist(6) 100
set energylist(7) 100
set energylist(8) 100
set energylist(9) 100
set energylist(10) 100
set energylist(11) 100
set energylist(12) 100
set energylist(13) 100
set energylist(14) 100
set energylist(15) 100
set maxEnergyNode 0

#===================================
#       global variables
#===================================
array set NMC {}
global set GNMC 
array set weight {}
array set node_X1_Position {}
array set node_Y1_Position {}
array set node_X2_Position {}
array set node_Y2_Position {}
global set clusterHeads  
set globalNMC 0
array set powerSourceType {}
array set cbr {}
array set udp {}
array set sctp {}
array set cbr {}

#===================================
#        Nodes status       
#===================================

#powerSource type set : 0 unlimitted power source , 1 limitted power source
for {set i 0} { $i < 16 } { incr i } {
    set powerSourceType($i) 1
}
set powerSourceType(3) 0
set powerSourceType(5) 0

#===================================
#          Node's power usage
#===================================
proc powerUsage {node} {
    set ET 0.09
}

#===================================
#          Node's Position
#===================================
proc updateNodePosition {} {
    global n node_X1_Position node_Y1_Position val

    for {set i 0} {$i < $val(nn)} {incr i} {
        set node_X1_Position($i) [$n($i) set X_]
        set node_Y1_Position($i) [$n($i) set Y_]
    }
}

updateNodePosition

#===================================
#              NMC
#===================================
proc setNMC {row col value} {
    global NMC
    set NMC($row,$col) $value
    
}

proc getNMC {row col} {
    global NMC
    # puts "the nmc is : $NMC($row,$col)"  
    return $NMC($row,$col) 
}

#===================================
#         calculate  NMC
#===================================
proc calculateDistance {node1 node2} {
    set node1_X [$node1 set X_]
    set node1_Y [$node1 set Y_]
    set node2_X [$node2 set X_]
    set node2_Y [$node2 set Y_]

    set distance [expr {sqrt(pow($node1_X - $node2_X, 2) + pow($node1_Y - $node2_Y, 2))}]
    return $distance
}


proc calculateVelocity {node} {
    
    global node_X1_Position node_Y1_Position n

    for {set index 0} {$index < 16} {incr index} {

        if {$node == $n($index)} {
        
            set node_X2 [$node set X_]
            set node_Y2 [$node set Y_]
            set node_X1 $node_X1_Position($index)
            set node_Y1 $node_Y1_Position($index)

            set dispachment [expr {sqrt(pow($node_X2 - $node_X1 , 2)) + pow($node_Y2 - $node_Y1 , 2)}]
            return $dispachment
        }
    }
}

proc calculateNMC {} {
    global n NMC powerSourceType

    for {set i 0} {$i < 16} {incr i} {
        for {set j 0} {$j < 16} {incr j} {
            if {$i == $j} {
                continue
            } else {
                set distance [calculateDistance $n($i) $n($j)]
                set range 250
                set v1 [calculateVelocity $n($i)]
                set v2 [calculateVelocity $n($j)]
                set velocities [expr {$v1 + $v2}]
                set nmcValue [expr {($range - $distance) / ($velocities + 1)}]
                setNMC $i $j $nmcValue
            }
        }
    }
}

proc calculateGlobalNMC {} {

    global NMC n GNMC 
    set sum 0
    set counter 0
    for {set i 0} {$i < 16} {incr i} {
        for {set j 0} {$j < 16} {incr j} {
            if {$i == $j} {
                continue
            } else {
                set value [getNMC $i $j]
                if {$value > 0} {
                   set sum [expr {$value + $sum}] 
                   incr counter
                }
            }
        }
    }
    set GNMC [expr {$sum / $counter}]

    puts "the global NMC is : $GNMC"
}


proc calculateWeight {} {
    global weight n NMC GNMC
    set x 0
    set neibour 0
    set sum 0
    for {set i 0} {$i < 16} {incr i} {
        set sum 0
        set nmcValue 0
        set neibour 0 
        for {set j 0} {$j < 16 } {incr j} {
            if {$i == $j} {
                continue 
            } else {
                set nmcValue [getNMC $i $j]      
                if {$nmcValue > 0} {
                    set sum [expr {$nmcValue + $sum}]
                    incr neibour
                }   
            }
        }
        set x [expr {$sum / $GNMC}]
        set weight($i) $x
        
        puts "weight node($i) is $weight($i)"
        puts "sum of node($i) is $sum"
    }
}

calculateNMC
calculateGlobalNMC
calculateWeight

#===================================
#        clustring        
#===================================
proc setCluster {} {
    global n weight clusterHeads powerSourceType

    set minWeight 5000
    set minWeightNode 5000

    for {set i 0 } { $i < 16 } {incr i } {
        set a $weight($i)
        if {$a < $minWeight } {
        set minWeightNode $i
        set minWeight $a    
        }
    }

    puts "the minWight is node($minWeightNode)"
    puts "the minimum weight is : $minWeight"
    $n($minWeightNode) color "red"
    set clusterHeads $minWeightNode
}

setCluster
$ns at 0.1 setCluster

#===================================
#           send packet        
#===================================
proc sendPacket1 {} {
    global n clusterHeads ns cbr

    # Create links between clusterHeads and other nodes
    for {set i 0} {$i < 16} {incr i} {
            $ns multihome-add-interface $n($i) $n($i)
            $ns duplex-link $n($clusterHeads) $n($i) 250kb 200ms DropTail
    }

    for {set i 0} { $i < 16 } {incr i} {
        if {$i != $clusterHeads} {
            set sctp($i) [new Agent/SCTP]
            $ns multihome-attach-agent $n($i) $sctp($i)
            $sctp($i) set fid_ 0 
            $sctp($i) set debugMask_ -1
            $sctp($i) set debugFileIndex_ 0
            $sctp($i) set mtu_ 1500
            $sctp($i) set dataChunkSize_ 1468
            $sctp($i) set numOutStreams_ 1
            $sctp($i) set oneHeartbeatTimer_ 0   # turns off heartbeating
        }
    }

    # Create and configure SCTP agent
    set sctp($clusterHeads) [new Agent/SCTP]
    $ns multihome-attach-agent $n($clusterHeads) $sctp($clusterHeads)
    $sctp($clusterHeads) set debugMask_ -1
    $sctp($clusterHeads) set debugFileIndex_ 1
    $sctp($clusterHeads) set mtu_ 1500
    $sctp($clusterHeads) set initialRwnd_ 131072 
    $sctp($clusterHeads) set useDelayedSacks_ 1


    for {set i 0} { $i < 16 } { incr i } {
        if {$i != $clusterHeads} {
            $ns connect $sctp($i) $sctp($clusterHeads)
            $sctp($i) set-primary-destination $n($clusterHeads)
        }

    }

    # Create FTP applications and attach them to the SCTP agent
    for {set i 0} {$i < 16} {incr i} {
        if {$i != $clusterHeads} {
            set ftp($i) [new Application/FTP]
            $ftp($i) attach-agent $sctp($i)       
            $ftp($i) set packetSize_ 1024
            $ftp($i) set rate_ 250kb     
        }
    }


    $ns at 2.0 "$ftp(2) start"   

}

proc sendPacket2 {} {
    global n clusterHeads ns cbr

    # Create links between clusterHeads and other nodes
    for {set i 0} {$i < 16} {incr i} {
            $ns multihome-add-interface $n($i) $n($i)
            $ns duplex-link $n($clusterHeads) $n($i) 250kb 200ms DropTail
    }

    for {set i 0} { $i < 16 } {incr i} {
        if {$i != $clusterHeads} {
            set sctp($i) [new Agent/SCTP]
            $ns multihome-attach-agent $n($i) $sctp($i)
            $sctp($i) set fid_ 0 
            $sctp($i) set debugMask_ -1
            $sctp($i) set debugFileIndex_ 0
            $sctp($i) set mtu_ 1500
            $sctp($i) set dataChunkSize_ 1468
            $sctp($i) set numOutStreams_ 1
            $sctp($i) set oneHeartbeatTimer_ 0   # turns off heartbeating
        }
    }

    # Create and configure SCTP agent
    set sctp($clusterHeads) [new Agent/SCTP]
    $ns multihome-attach-agent $n($clusterHeads) $sctp($clusterHeads)
    $sctp($clusterHeads) set debugMask_ -1
    $sctp($clusterHeads) set debugFileIndex_ 1
    $sctp($clusterHeads) set mtu_ 1500
    $sctp($clusterHeads) set initialRwnd_ 131072 
    $sctp($clusterHeads) set useDelayedSacks_ 1


    for {set i 0} { $i < 16 } { incr i } {
        if {$i != $clusterHeads} {
            $ns connect $sctp($i) $sctp($clusterHeads)
            $sctp($i) set-primary-destination $n($clusterHeads)
        }

    }

    # Create FTP applications and attach them to the SCTP agent
    for {set i 0} {$i < 16} {incr i} {
        if {$i != $clusterHeads} {
            set ftp($i) [new Application/FTP]
            $ftp($i) attach-agent $sctp($i)       
            $ftp($i) set packetSize_ 1024
            $ftp($i) set rate_ 250kb     
        }
    }

    $ns at 0.6 "$ftp(6) start" 

}

proc sendPacket3 {} {
    global n clusterHeads ns cbr

    # Create links between clusterHeads and other nodes
    for {set i 0} {$i < 16} {incr i} {
            $ns multihome-add-interface $n($i) $n($i)
            $ns duplex-link $n($clusterHeads) $n($i) 250kb 200ms DropTail    
    }

    for {set i 0} { $i < 16 } {incr i} {
        if {$i != $clusterHeads} {
            set sctp($i) [new Agent/SCTP]
            $ns multihome-attach-agent $n($i) $sctp($i)
            $sctp($i) set fid_ 0 
            $sctp($i) set debugMask_ -1
            $sctp($i) set debugFileIndex_ 0
            $sctp($i) set mtu_ 1500
            $sctp($i) set dataChunkSize_ 1468
            $sctp($i) set numOutStreams_ 1
            $sctp($i) set oneHeartbeatTimer_ 0   # turns off heartbeating
        }
    }

    # Create and configure SCTP agent
    set sctp($clusterHeads) [new Agent/SCTP]
    $ns multihome-attach-agent $n($clusterHeads) $sctp($clusterHeads)
    $sctp($clusterHeads) set debugMask_ -1
    $sctp($clusterHeads) set debugFileIndex_ 1
    $sctp($clusterHeads) set mtu_ 1500
    $sctp($clusterHeads) set initialRwnd_ 131072 
    $sctp($clusterHeads) set useDelayedSacks_ 1


    for {set i 0} { $i < 16 } { incr i } {
        if {$i != $clusterHeads} {
            $ns connect $sctp($i) $sctp($clusterHeads)
            $sctp($i) set-primary-destination $n($clusterHeads)
        }

    }

    # Create FTP applications and attach them to the SCTP agent
    for {set i 0} {$i < 16} {incr i} {
        if {$i != $clusterHeads} {
            set ftp($i) [new Application/FTP]
            $ftp($i) attach-agent $sctp($i)       
            $ftp($i) set packetSize_ 1024
            $ftp($i) set rate_ 250kbb     
        }
    }

    # for {set i 0} {$i < 16} {incr i} {
    #     set udp($i) [new Agent/UDP]
    #     $ns attach-agent $n($i) $udp($i)
    #     set null($clusterHeads) [new Agent/Null]
    #     $ns attach-agent $n($clusterHeads) $null($clusterHeads)
    #     $ns connect $udp($i) $null($clusterHeads)
    #     $udp($i) set packetSize_ 1024
    # }

    # for {set i 0} {$i < 16} {incr i} {
    #     #Setup a CBR Application over UDP connection
    #     set cbr($i) [new Application/Traffic/CBR]
    #     $cbr($i) attach-agent $sctp($i)
    #     $cbr($i) set packetSize_ 1024
    #     $cbr($i) set rate_ 250kb
    #     $cbr($i) set random_ null
    # }

    $ns at 1.0 "$ftp(3) start" 
    # $ns at 1.0 "$cbr(3) start" 

}
    
$ns at 0.2 sendPacket1
$ns at 0.5 sendPacket2
$ns at 0.9 sendPacket3

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile

    set PERL "/usr/bin/perl"
    set USERHOME [exec env | grep "^HOME" | sed /^HOME=/s/^HOME=//]
    set NSHOME "$USERHOME/proj/ns-allinone-2.1b8.sctp"
    set XGRAPH "$NSHOME/bin/xgraph"
    set SETFID "$NSHOME/ns-2.1b8/bin/set_flow_id"
    set RAW2XG_SCTP "$NSHOME/ns-2.1b8/bin/raw2xg-sctp"

    $ns flush-trace
    close $namfile
    close $tracefile

    # exec nam code.nam &

    exit 0
}

for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n($i) reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run



