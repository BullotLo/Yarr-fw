----------------------------------------------------------------------------------
-- Company: LBNL
-- Engineer: Arnaud Sautaux
-- 
-- Create Date: 09/27/2016 04:46:45 PM
-- Design Name: YARR Top Level BRAM version
-- Module Name: top_level - Behavioral
-- Project Name: YARR
-- Target Devices: XC7k160T
-- Tool Versions: Vivado v2016.2 (64-bit)
-- Description: The YARR top level for the BRAM version
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.app_pkg.all;
use work.board_pkg.all;

entity top_level is
    Port (  ---------------------------------------------------------------------------
            -- Xilinx Hard IP Interface
            --  . Clock and Resets
            pcie_clk_p : in std_logic;
            pcie_clk_n : in std_logic;
            clk200_n : in STD_LOGIC;
            clk200_p : in STD_LOGIC;
            --rst_n_i : in STD_LOGIC;
            sys_rst_n_i : in STD_LOGIC;
            --  . Serial I/F
            pci_exp_txn : out std_logic_vector(4-1 downto 0);--output wire [4                                -1:0] pci_exp_txn           ,
            pci_exp_txp : out std_logic_vector(4-1 downto 0);--output wire [4                                -1:0] pci_exp_txp           ,
            pci_exp_rxn : in std_logic_vector(4-1 downto 0);--input  wire [4                                -1:0] pci_exp_rxn           ,
            pci_exp_rxp : in std_logic_vector(4-1 downto 0);
            -- . IO
            --usr_sw_i : in STD_LOGIC_VECTOR (2 downto 0);
            usr_led_o : out STD_LOGIC_VECTOR (0 downto 0);
            --front_led_o : out STD_LOGIC_VECTOR (3 downto 0);
            
            ---------------------------------------------------------
            -- FMC
            ---------------------------------------------------------
            -- Trigger input
            --ext_trig_i_p       : in std_logic_vector(0 downto 0);
            --ext_trig_i_n       : in std_logic_vector(0 downto 0);
            --ext_busy_o_p       : out std_logic;
            --ext_busy_o_n       : out std_logic;
            -- LVDS buffer
            --pwdn_l            : out std_logic_vector(2 downto 0);
            -- GPIO
            --io              : inout std_logic_vector(2 downto 0);
            -- FE-I4
            fe_clk_p        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
            fe_clk_n        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
            fe_cmd_p        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
            fe_cmd_n        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
            fe_data_p        : in  std_logic_vector((c_RX_CHANNELS*c_RX_NUM_LANES)-1 downto 0);
            fe_data_n        : in  std_logic_vector((c_RX_CHANNELS*c_RX_NUM_LANES)-1 downto 0);
            -- I2c
            --sda_io                : inout std_logic;
            --scl_io                    : inout std_logic;
            -- EUDET TLU
            --eudet_trig_p : in std_logic;
            --eudet_trig_n : in std_logic;
            --eudet_busy_p : out std_logic;
            --eudet_busy_n : out std_logic;
            --eudet_rst_p : in std_logic;
            --eudet_rst_n : in std_logic;
            --eudet_clk_p : out std_logic;
            --eudet_clk_n : out std_logic;
            -- SPI
            scl_o   : out std_logic;
            sda_o   : out std_logic;
            sdi_i   : in std_logic;
            latch_o : out std_logic
            
            -- . DDR3
--            ddr3_dq       : inout std_logic_vector(63 downto 0);
--            ddr3_dqs_p    : inout std_logic_vector(7 downto 0);
--            ddr3_dqs_n    : inout std_logic_vector(7 downto 0);
      
--            ddr3_addr     : out   std_logic_vector(14 downto 0);
--            ddr3_ba       : out   std_logic_vector(2 downto 0);
--            ddr3_ras_n    : out   std_logic;
--            ddr3_cas_n    : out   std_logic;
--            ddr3_we_n     : out   std_logic;
--            ddr3_reset_n  : out   std_logic;
--            ddr3_ck_p     : out   std_logic_vector(0 downto 0);
--            ddr3_ck_n     : out   std_logic_vector(0 downto 0);
--            ddr3_cke      : out   std_logic_vector(0 downto 0);
--            ddr3_cs_n     : out   std_logic_vector(0 downto 0);
--            ddr3_dm       : out   std_logic_vector(7 downto 0);
--            ddr3_odt      : out   std_logic_vector(0 downto 0)
            );
end top_level;

architecture Behavioral of top_level is
    
    constant AXI_BUS_WIDTH : integer := 64;
    
    
    
    COMPONENT pcie_7x_0
      PORT (
          pci_exp_txp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          pci_exp_txn : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          pci_exp_rxp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          pci_exp_rxn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          user_clk_out : OUT STD_LOGIC;
          user_reset_out : OUT STD_LOGIC;
          user_lnk_up : OUT STD_LOGIC;
          user_app_rdy : OUT STD_LOGIC;
          tx_buf_av : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
          tx_cfg_req : OUT STD_LOGIC;
          tx_err_drop : OUT STD_LOGIC;
          s_axis_tx_tready : OUT STD_LOGIC;
          s_axis_tx_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
          s_axis_tx_tkeep : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          s_axis_tx_tlast : IN STD_LOGIC;
          s_axis_tx_tvalid : IN STD_LOGIC;
          s_axis_tx_tuser : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          m_axis_rx_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
          m_axis_rx_tkeep : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
          m_axis_rx_tlast : OUT STD_LOGIC;
          m_axis_rx_tvalid : OUT STD_LOGIC;
          m_axis_rx_tready : IN STD_LOGIC;
          m_axis_rx_tuser : OUT STD_LOGIC_VECTOR(21 DOWNTO 0);
          cfg_status : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_command : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_dstatus : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_dcommand : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_lstatus : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_lcommand : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_dcommand2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_pcie_link_state : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          cfg_pmcsr_pme_en : OUT STD_LOGIC;
          cfg_pmcsr_powerstate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
          cfg_pmcsr_pme_status : OUT STD_LOGIC;
          cfg_received_func_lvl_rst : OUT STD_LOGIC;
          cfg_interrupt : IN STD_LOGIC;
          cfg_interrupt_rdy : OUT STD_LOGIC;
          cfg_interrupt_assert : IN STD_LOGIC;
          cfg_interrupt_di : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          cfg_interrupt_do : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
          cfg_interrupt_mmenable : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          cfg_interrupt_msienable : OUT STD_LOGIC;
          cfg_interrupt_msixenable : OUT STD_LOGIC;
          cfg_interrupt_msixfm : OUT STD_LOGIC;
          cfg_interrupt_stat : IN STD_LOGIC;
          cfg_pciecap_interrupt_msgnum : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
          cfg_to_turnoff : OUT STD_LOGIC;
          cfg_bus_number : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
          cfg_device_number : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
          cfg_function_number : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          cfg_msg_received : OUT STD_LOGIC;
          cfg_msg_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
          cfg_bridge_serr_en : OUT STD_LOGIC;
          cfg_slot_control_electromech_il_ctl_pulse : OUT STD_LOGIC;
          cfg_root_control_syserr_corr_err_en : OUT STD_LOGIC;
          cfg_root_control_syserr_non_fatal_err_en : OUT STD_LOGIC;
          cfg_root_control_syserr_fatal_err_en : OUT STD_LOGIC;
          cfg_root_control_pme_int_en : OUT STD_LOGIC;
          cfg_aer_rooterr_corr_err_reporting_en : OUT STD_LOGIC;
          cfg_aer_rooterr_non_fatal_err_reporting_en : OUT STD_LOGIC;
          cfg_aer_rooterr_fatal_err_reporting_en : OUT STD_LOGIC;
          cfg_aer_rooterr_corr_err_received : OUT STD_LOGIC;
          cfg_aer_rooterr_non_fatal_err_received : OUT STD_LOGIC;
          cfg_aer_rooterr_fatal_err_received : OUT STD_LOGIC;
          cfg_msg_received_err_cor : OUT STD_LOGIC;
          cfg_msg_received_err_non_fatal : OUT STD_LOGIC;
          cfg_msg_received_err_fatal : OUT STD_LOGIC;
          cfg_msg_received_pm_as_nak : OUT STD_LOGIC;
          cfg_msg_received_pm_pme : OUT STD_LOGIC;
          cfg_msg_received_pme_to_ack : OUT STD_LOGIC;
          cfg_msg_received_assert_int_a : OUT STD_LOGIC;
          cfg_msg_received_assert_int_b : OUT STD_LOGIC;
          cfg_msg_received_assert_int_c : OUT STD_LOGIC;
          cfg_msg_received_assert_int_d : OUT STD_LOGIC;
          cfg_msg_received_deassert_int_a : OUT STD_LOGIC;
          cfg_msg_received_deassert_int_b : OUT STD_LOGIC;
          cfg_msg_received_deassert_int_c : OUT STD_LOGIC;
          cfg_msg_received_deassert_int_d : OUT STD_LOGIC;
          cfg_msg_received_setslotpowerlimit : OUT STD_LOGIC;
          cfg_vc_tcvc_map : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
          sys_clk : IN STD_LOGIC;
          sys_rst_n : IN STD_LOGIC
      );
    END COMPONENT;
    
    component app is
        Generic( 
                DEBUG_C : std_logic_vector(3 downto 0) := "0000"; 
                address_mask_c : STD_LOGIC_VECTOR(32-1 downto 0) := X"000FFFFF"; 
                DMA_MEMORY_SELECTED : string := "BRAM" -- DDR3, BRAM, DEMUX 
        );
	Port ( clk_i : in STD_LOGIC;
               sys_clk_n_i : IN STD_LOGIC;
               sys_clk_p_i : IN STD_LOGIC;
               rst_i : in STD_LOGIC;
               
               
               
               user_lnk_up_i : in STD_LOGIC;
               user_app_rdy_i : in STD_LOGIC;
               
               -- AXI-Stream bus
               m_axis_tx_tready_i : in STD_LOGIC;
               m_axis_tx_tdata_o : out STD_LOGIC_VECTOR(AXI_BUS_WIDTH-1 DOWNTO 0);
               m_axis_tx_tkeep_o : out STD_LOGIC_VECTOR(AXI_BUS_WIDTH/8-1 DOWNTO 0);
               m_axis_tx_tlast_o : out STD_LOGIC;
               m_axis_tx_tvalid_o : out STD_LOGIC;
               m_axis_tx_tuser_o : out STD_LOGIC_VECTOR(3 DOWNTO 0);
               s_axis_rx_tdata_i : in STD_LOGIC_VECTOR(AXI_BUS_WIDTH-1 DOWNTO 0);
               s_axis_rx_tkeep_i : in STD_LOGIC_VECTOR(AXI_BUS_WIDTH/8-1 DOWNTO 0);
               s_axis_rx_tlast_i : in STD_LOGIC;
               s_axis_rx_tvalid_i : in STD_LOGIC;
               s_axis_rx_tready_o : out STD_LOGIC;
               s_axis_rx_tuser_i : in STD_LOGIC_VECTOR(21 DOWNTO 0);
               
               -- PCIe interrupt config
               cfg_interrupt_o : out STD_LOGIC;
               cfg_interrupt_rdy_i : in STD_LOGIC;
               cfg_interrupt_assert_o : out STD_LOGIC;
               cfg_interrupt_di_o : out STD_LOGIC_VECTOR(7 DOWNTO 0);
               cfg_interrupt_do_i : in STD_LOGIC_VECTOR(7 DOWNTO 0);
               cfg_interrupt_mmenable_i : in STD_LOGIC_VECTOR(2 DOWNTO 0);
               cfg_interrupt_msienable_i : in STD_LOGIC;
               cfg_interrupt_msixenable_i : in STD_LOGIC;
               cfg_interrupt_msixfm_i : in STD_LOGIC;
               cfg_interrupt_stat_o : out STD_LOGIC;
               cfg_pciecap_interrupt_msgnum_o : out STD_LOGIC_VECTOR(4 DOWNTO 0);
               
               -- PCIe ID
               cfg_bus_number_i : in STD_LOGIC_VECTOR(7 DOWNTO 0);
               cfg_device_number_i : in STD_LOGIC_VECTOR(4 DOWNTO 0);
               cfg_function_number_i : in STD_LOGIC_VECTOR(2 DOWNTO 0);
               
               -- PCIe debug
               tx_err_drop_i : in STD_LOGIC;
               cfg_dstatus_i : in STD_LOGIC_VECTOR(15 DOWNTO 0);
               
               --DDR3
               ddr3_dq_io       : inout std_logic_vector(63 downto 0);
               ddr3_dqs_p_io    : inout std_logic_vector(7 downto 0);
               ddr3_dqs_n_io    : inout std_logic_vector(7 downto 0);
               
               --init_calib_complete_o : out std_logic;
         
               ddr3_addr_o     : out   std_logic_vector(14 downto 0);
               ddr3_ba_o       : out   std_logic_vector(2 downto 0);
               ddr3_ras_n_o    : out   std_logic;
               ddr3_cas_n_o    : out   std_logic;
               ddr3_we_n_o     : out   std_logic;
               ddr3_reset_n_o  : out   std_logic;
               ddr3_ck_p_o     : out   std_logic_vector(0 downto 0);
               ddr3_ck_n_o    : out   std_logic_vector(0 downto 0);
               ddr3_cke_o      : out   std_logic_vector(0 downto 0);
               ddr3_cs_n_o     : out   std_logic_vector(0 downto 0);
               ddr3_dm_o       : out   std_logic_vector(7 downto 0);
               ddr3_odt_o      : out   std_logic_vector(0 downto 0);
               
                ---------------------------------------------------------
                -- FMC
                ---------------------------------------------------------
                -- Trigger input
                ext_trig_i        : in std_logic_vector(3 downto 0);
                --ext_busy_o        : out std_logic;
                -- LVDS buffer
                pwdn_l            : out std_logic_vector(2 downto 0);
                -- GPIO
                --io              : inout std_logic_vector(2 downto 0);
                -- FE-I4
                fe_clk_p        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
                fe_clk_n        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
                fe_cmd_p        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
                fe_cmd_n        : out std_logic_vector(c_TX_CHANNELS-1 downto 0);
                fe_data_p        : in  std_logic_vector((c_RX_CHANNELS*c_RX_NUM_LANES)-1 downto 0);
                fe_data_n        : in  std_logic_vector((c_RX_CHANNELS*c_RX_NUM_LANES)-1 downto 0);
                -- I2c
                sda_io                : inout std_logic;
                scl_io                    : inout std_logic;
                -- EUDET
                eudet_clk_o : out std_logic;
                eudet_trig_i : in std_logic;
                eudet_rst_i : in std_logic;
                eudet_busy_o : out std_logic;
                -- SPI
                scl_o   : out std_logic;
                sda_o   : out std_logic;
                sdi_i : in std_logic;
                latch_o : out std_logic;
            
               --I/O
               usr_sw_i : in STD_LOGIC_VECTOR (2 downto 0);
               usr_led_o : out STD_LOGIC_VECTOR (3 downto 0);
               front_led_o : out STD_LOGIC_VECTOR (3 downto 0)
               );
    end component;
    
    

    

    
    --Clocks
    signal sys_clk : STD_LOGIC;
    --signal clk200 : STD_LOGIC;
    signal aclk : STD_LOGIC;
    
    signal arstn_s : STD_LOGIC;
    signal rst_s : STD_LOGIC;
    
    --Wishbone bus
    
    signal usr_led_s : std_logic_vector(3 downto 0);
    --signal count_s : STD_LOGIC_VECTOR (28 downto 0);
    
    
    -- AXI-stream bus to PCIE
    signal s_axis_tx_tready_s : STD_LOGIC;
    signal s_axis_tx_tdata_s : STD_LOGIC_VECTOR(AXI_BUS_WIDTH-1 DOWNTO 0);
    signal s_axis_tx_tkeep_s : STD_LOGIC_VECTOR(AXI_BUS_WIDTH/8-1 DOWNTO 0);
    signal s_axis_tx_tlast_s : STD_LOGIC;
    signal s_axis_tx_tvalid_s : STD_LOGIC;
    signal s_axis_tx_tuser_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal m_axis_rx_tdata_s : STD_LOGIC_VECTOR(AXI_BUS_WIDTH-1 DOWNTO 0);
    signal m_axis_rx_tkeep_s : STD_LOGIC_VECTOR(AXI_BUS_WIDTH/8-1 DOWNTO 0);
    signal m_axis_rx_tlast_s : STD_LOGIC;
    signal m_axis_rx_tvalid_s : STD_LOGIC;
    signal m_axis_rx_tready_s : STD_LOGIC;
    signal m_axis_rx_tuser_s : STD_LOGIC_VECTOR(21 DOWNTO 0);
    
    -- PCIE signals
    signal user_lnk_up_s : STD_LOGIC;
    signal user_app_rdy_s : STD_LOGIC;
    signal tx_err_drop_s : STD_LOGIC;
    signal cfg_interrupt_s : STD_LOGIC;
    signal cfg_interrupt_rdy_s : STD_LOGIC;
    signal cfg_interrupt_assert_s : STD_LOGIC;
    signal cfg_interrupt_di_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal cfg_interrupt_do_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal cfg_interrupt_mmenable_s : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal cfg_interrupt_msienable_s : STD_LOGIC;
    signal cfg_interrupt_msixenable_s : STD_LOGIC;
    signal cfg_interrupt_msixfm_s : STD_LOGIC;
    signal cfg_interrupt_stat_s : STD_LOGIC;
    signal cfg_pciecap_interrupt_msgnum_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    
    -- PCIE ID
    signal cfg_bus_number_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal cfg_device_number_s : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal cfg_function_number_s : STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    --PCIE debug
    signal cfg_dstatus_s : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- EUDET
    signal eudet_clk_s : std_logic;
    signal eudet_trig_s : std_logic;
    signal eudet_busy_s : std_logic;
    signal eudet_rst_s : std_logic;


    signal ext_trig_i : std_logic_vector(3 downto 0);
    signal ext_busy_o : std_logic;
    
begin

-- LVDS input to internal single
--  CLK_IBUFDS : IBUFDS
--  generic map(
--    IOSTANDARD => "DEFAULT"
--  )
--  port map(
--    I  => clk200_p,
--    IB => clk200_n,
--    O  => clk200
--  );

--    design_1_0: component design_1
--     port map (
--      CLK_IN_D_clk_n(0) => pcie_clk_n,
--      CLK_IN_D_clk_p(0) => pcie_clk_p,
--      IBUF_OUT(0) => sys_clk
--    );    

    -- EUDET buffer
    --eudet_clk_buf : OBUFDS port map (O => eudet_clk_p, OB => eudet_clk_n, I => eudet_clk_s);
    --eudet_busy_buf : OBUFDS port map (O => eudet_busy_p, OB => eudet_busy_n, I => eudet_busy_s);
    --eudet_rst_buf : IBUFDS generic map(DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => eudet_rst_s, I => eudet_rst_p, IB => eudet_rst_n);
    --eudet_trig_buf : IBUFDS generic map(DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => eudet_trig_s, I => eudet_trig_p, IB => eudet_trig_n);
    -- HitOr
    --ext_trig_buf_0 : IBUFDS generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => ext_trig_i(0), I => ext_trig_i_p(0), IB => ext_trig_i_n(0));
    --ext_trig_buf_1 : IBUFDS generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => ext_trig_i(1), I => ext_trig_i_p(1), IB => ext_trig_i_n(1));
    --ext_trig_buf_2 : IBUFDS generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => ext_trig_i(2), I => ext_trig_i_p(2), IB => ext_trig_i_n(2));
    --ext_trig_buf_3 : IBUFDS generic map (DIFF_TERM => TRUE, IBUF_LOW_PWR => FALSE) port map (O => ext_trig_i(3), I => ext_trig_i_p(3), IB => ext_trig_i_n(3));
    --ext_busy_buf : OBUFDS port map (O => ext_busy_o_p, OB => ext_busy_o_n, I => ext_busy_o);

  
   refclk_ibuf : IBUFDS_GTE2
       port map(
         O       => sys_clk,
         ODIV2   => open,
         I       => pcie_clk_p,
         IB      => pcie_clk_n,
         CEB     => '0');

 

  rst_s <= not sys_rst_n_i;
  arstn_s <= sys_rst_n_i;-- or rst_n_i;
  


   
 
    
    pcie_0 : pcie_7x_0
      PORT MAP (
        pci_exp_txp => pci_exp_txp,
        pci_exp_txn => pci_exp_txn,
        pci_exp_rxp => pci_exp_rxp,
        pci_exp_rxn => pci_exp_rxn,
        user_clk_out => aclk,
        user_reset_out => open, -- TODO
        user_lnk_up => user_lnk_up_s,
        user_app_rdy => user_app_rdy_s,
        tx_err_drop => tx_err_drop_s,
        s_axis_tx_tready => s_axis_tx_tready_s,
        s_axis_tx_tdata => s_axis_tx_tdata_s,
        s_axis_tx_tkeep => s_axis_tx_tkeep_s,
        s_axis_tx_tlast => s_axis_tx_tlast_s,
        s_axis_tx_tvalid => s_axis_tx_tvalid_s,
        s_axis_tx_tuser => s_axis_tx_tuser_s,
        m_axis_rx_tdata => m_axis_rx_tdata_s,
        m_axis_rx_tkeep => m_axis_rx_tkeep_s,
        m_axis_rx_tlast => m_axis_rx_tlast_s,
        m_axis_rx_tvalid => m_axis_rx_tvalid_s,
        m_axis_rx_tready => m_axis_rx_tready_s,
        m_axis_rx_tuser => m_axis_rx_tuser_s,
        cfg_interrupt => cfg_interrupt_s,
        cfg_interrupt_rdy => cfg_interrupt_rdy_s,
        cfg_interrupt_assert => cfg_interrupt_assert_s,
        cfg_interrupt_di => cfg_interrupt_di_s,
        cfg_interrupt_do => cfg_interrupt_do_s,
        cfg_interrupt_mmenable => cfg_interrupt_mmenable_s,
        cfg_interrupt_msienable => cfg_interrupt_msienable_s,
        cfg_interrupt_msixenable => cfg_interrupt_msixenable_s,
        cfg_interrupt_msixfm => cfg_interrupt_msixfm_s,
        cfg_interrupt_stat => cfg_interrupt_stat_s,
        cfg_pciecap_interrupt_msgnum => cfg_pciecap_interrupt_msgnum_s,
        cfg_dstatus => cfg_dstatus_s,
        
        cfg_bus_number => cfg_bus_number_s,
        cfg_device_number => cfg_device_number_s,
        cfg_function_number => cfg_function_number_s,
        
        sys_clk => sys_clk,
        sys_rst_n => sys_rst_n_i
      );
      
      app_0:app
      Generic map( 
	   DEBUG_C => "0000",
        address_mask_c => X"000FFFFF",
        DMA_MEMORY_SELECTED => "BRAM" -- DDR3, BRAM 
        )
      port map(
        clk_i => aclk,
        sys_clk_n_i => clk200_n,
        sys_clk_p_i => clk200_p,
        rst_i => rst_s,
        user_lnk_up_i => user_lnk_up_s,
        user_app_rdy_i => user_app_rdy_s,
        
        -- AXI-Stream bus
        m_axis_tx_tready_i => s_axis_tx_tready_s,
        m_axis_tx_tdata_o => s_axis_tx_tdata_s,
        m_axis_tx_tkeep_o => s_axis_tx_tkeep_s,
        m_axis_tx_tlast_o => s_axis_tx_tlast_s,
        m_axis_tx_tvalid_o => s_axis_tx_tvalid_s,
        m_axis_tx_tuser_o => s_axis_tx_tuser_s,
        s_axis_rx_tdata_i => m_axis_rx_tdata_s,
        s_axis_rx_tkeep_i => m_axis_rx_tkeep_s,
        s_axis_rx_tlast_i => m_axis_rx_tlast_s,
        s_axis_rx_tvalid_i => m_axis_rx_tvalid_s,
        s_axis_rx_tready_o => m_axis_rx_tready_s,
        s_axis_rx_tuser_i => m_axis_rx_tuser_s,
        
        -- PCIe interrupt config
        cfg_interrupt_o => cfg_interrupt_s,
        cfg_interrupt_rdy_i => cfg_interrupt_rdy_s,
        cfg_interrupt_assert_o => cfg_interrupt_assert_s,
        cfg_interrupt_di_o => cfg_interrupt_di_s,
        cfg_interrupt_do_i => cfg_interrupt_do_s,
        cfg_interrupt_mmenable_i => cfg_interrupt_mmenable_s,
        cfg_interrupt_msienable_i => cfg_interrupt_msienable_s,
        cfg_interrupt_msixenable_i => cfg_interrupt_msixenable_s,
        cfg_interrupt_msixfm_i => cfg_interrupt_msixfm_s,
        cfg_interrupt_stat_o => cfg_interrupt_stat_s,
        cfg_pciecap_interrupt_msgnum_o => cfg_pciecap_interrupt_msgnum_s,
        
        -- PCIe ID
        cfg_bus_number_i => cfg_bus_number_s,
        cfg_device_number_i =>  cfg_device_number_s,
        cfg_function_number_i => cfg_function_number_s,
        
        -- PCIe debug
        tx_err_drop_i => tx_err_drop_s,
        cfg_dstatus_i => cfg_dstatus_s,
        
        --DDR3
        --ddr3_dq_io       => ddr3_dq,
        --ddr3_dqs_p_io    => ddr3_dqs_p,
        --ddr3_dqs_n_io    => ddr3_dqs_n,
        
        --init_calib_complete_o => init_calib_complete,
    
        --ddr3_addr_o     => ddr3_addr,
        --ddr3_ba_o       => ddr3_ba,
        --ddr3_ras_n_o    => ddr3_ras_n,
        --ddr3_cas_n_o    => ddr3_cas_n,
        --ddr3_we_n_o     => ddr3_we_n,
        --ddr3_reset_n_o  => ddr3_reset_n,
        --ddr3_ck_p_o     => ddr3_ck_p,
        --ddr3_ck_n_o     => ddr3_ck_n,
        --ddr3_cke_o      => ddr3_cke,
        --ddr3_cs_n_o     => ddr3_cs_n,
        --ddr3_dm_o       => ddr3_dm,
        --ddr3_odt_o      => ddr3_odt,

        ---------------------------------------------------------
        -- FMC
        ---------------------------------------------------------
        -- Trigger input
        ext_trig_i        => ext_trig_i,
        --ext_busy_o      => ext_busy_o,
        -- LVDS buffer
        pwdn_l            => open,
        -- GPIO
        --io                => io,
        -- FE-I4
        fe_clk_p          => fe_clk_p,
        fe_clk_n          => fe_clk_n,
        fe_cmd_p          => fe_cmd_p,
        fe_cmd_n          => fe_cmd_n,
        fe_data_p         => fe_data_p,
        fe_data_n         => fe_data_n,
        -- I2c
        --sda_io            => sda_io,
        --scl_io            => scl_io,
        --EUDET
        eudet_clk_o => eudet_clk_s,
        eudet_trig_i => eudet_trig_s,
        eudet_rst_i => not eudet_rst_s,
        eudet_busy_o => eudet_busy_s,
        --SPI
        scl_o => scl_o,
        sda_o => sda_o,
        sdi_i => sdi_i,
        latch_o => latch_o,
        
        --I/O
        usr_sw_i => "000",
        usr_led_o => usr_led_s,
        front_led_o => open--front_led_o
      );
      
      usr_led_o <= usr_led_s(0 downto 0);

      
  
end Behavioral;
