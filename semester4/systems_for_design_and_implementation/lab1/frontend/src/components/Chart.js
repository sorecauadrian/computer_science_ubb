import { useState } from "react";
import { IoStatsChartOutline } from "react-icons/io5";
import { Button, Modal } from "react-bootstrap";
import { Bar, Pie } from "react-chartjs-2";
import { Chart, registerables } from 'chart.js';
import dreams from "./dreams";

Chart.register(...registerables);

function BarChart()
{
    const [show, setShow] = useState(false);
    const [lucidityData, setLucidityData] = useState({});

    const handleClose = () => setShow(false);
    const handleShow = () => {
        setShow(true)
        generateLucidityData();
    };

    const generateLucidityData = () => {
        const lucidityCounts = {};
        dreams.forEach((dream) => {
            const lucidityValue = Math.round(dream.lucidity * 10) / 10; // rounding the value to one decimal place
            lucidityCounts[lucidityValue] = (lucidityCounts[lucidityValue] || 0) + 1;
        });

        const labels = Object.keys(lucidityCounts);
        labels.sort(function (lucidity1, lucidity2) {return lucidity1 - lucidity2;});
        const data = labels.map((label) => lucidityCounts[label]);

        setLucidityData({
            labels: labels,
            datasets: [
                {
                    label: "lucidity",
                    backgroundColor: "rgba(75, 192, 192, 1)",
                    borderColor: "rgba(0, 0, 0, 1)",
                    borderWidth: 1,
                    data: data
                }
            ]
        });
    };

    return (
        <>
            <div className="d-grid gap-2">
                <Button variant="primary" onClick={handleShow} data-testid="chart">
                    <IoStatsChartOutline />
                </Button>
            </div>
            
            <Modal show={show} onHide={handleClose} animation={false}>
                <Modal.Header closeButton>
                    <Modal.Title>
                        lucidity chart
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {Object.keys(lucidityData).length > 0 && (
                        <Bar
                            data={lucidityData}
                            options={{
                                title: {
                                    display: true,
                                    text: "lucidity distribution",
                                    fontSize: 20
                                },
                                legend: {
                                    display: true,
                                    position: "right"
                                }
                            }}
                            data-testid="barchart"
                        />
                    )}
                </Modal.Body>
            </Modal>
        </>
    );
}

export default BarChart;