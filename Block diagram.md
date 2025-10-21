AXI4-Lite Interface Block Diagram:  
This diagram shows an AXI4-Lite master-slave interface connected to an integrated RAM module.  
Master: Generates read/write requests along with addresses and data.  
Slave: Handles AXI handshaking signals (AWReady, WReady, ARReady, RReady) to coordinate transactions.  
RAM: Stores data at the specified addresses and provides read/write access based on control signals.  
Data flow: Write data and addresses go from master → slave → RAM, while read data flows from RAM → slave → master.  
Clock and reset: All operations are synchronous with clk and controlled by rst.  
This interface ensures controlled and synchronized memory access with proper AXI4-Lite handshaking.

<img width="2020" height="2080" alt="AXI4-LITE" src="https://github.com/user-attachments/assets/724dcf7c-c8c5-4442-86d5-ffc6cb0ddc38" />
