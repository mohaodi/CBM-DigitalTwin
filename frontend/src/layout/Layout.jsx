import React, { useState } from 'react';
import { Layout as AntLayout, Menu } from 'antd';
import { AppstoreOutlined, LineChartOutlined, ExperimentOutlined, DeploymentUnitOutlined, ControlOutlined } from '@ant-design/icons';
import '../styles/app.css';
import MineOverview from '../pages/MineOverview';
import Simulation from '../pages/Simulation';
import SchemePrediction from '../pages/SchemePrediction';
import RealtimePlatform from '../pages/RealtimePlatform';
import DecisionCenter from '../pages/DecisionCenter';

const { Sider, Content } = AntLayout;

export default function Layout() {
  const [page, setPage] = useState('mine');

  const pages = {
    mine: <MineOverview onOpenPrediction={() => setPage('scheme')} onOpenSimulation={() => setPage('simulation')} />,
    scheme: <SchemePrediction />,
    realtime: <RealtimePlatform />,
    decision: <DecisionCenter />,
    simulation: <Simulation />,
  };

  return (
    <AntLayout className="app-shell">
      <Sider width={196} className="app-sidebar">
        <div className="app-brand">
          <div className="brand-mark"><DeploymentUnitOutlined /></div>
          <div style={{ color: '#eef7fd', fontSize: 18, fontWeight: 700 }}>CBM Digital Twin</div>
          <div className="brand-subtitle">煤系气全生命周期智能化系统</div>
        </div>
        <Menu
          theme="dark"
          selectedKeys={[page]}
          onClick={(e) => setPage(e.key)}
          style={{ background: '#071b2b' }}
          items={[
            { key: 'mine', icon: <AppstoreOutlined />, label: '矿井全局孪生' },
            { key: 'realtime', icon: <LineChartOutlined />, label: '实时监测与数据库' },
            { key: 'scheme', icon: <DeploymentUnitOutlined />, label: '方案预测模型' },
            { key: 'decision', icon: <ControlOutlined />, label: '调控 · 诊断 · 评判' },
            { key: 'simulation', icon: <ExperimentOutlined />, label: '物理仿真中心' },
          ]}
        />
        <div className="sidebar-footer"><span>NSFC 联合基金重点项目</span><b>煤系气数字孪生平台</b><small>V15.10 · Research Platform</small></div>
      </Sider>
      <Content className="app-content">
        {pages[page]}
      </Content>
    </AntLayout>
  );
}
