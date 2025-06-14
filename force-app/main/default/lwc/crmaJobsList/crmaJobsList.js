import { LightningElement, wire, track  } from 'lwc';
import { getDataflowJobs } from "lightning/analyticsWaveApi";

export default class CrmaJobsList extends LightningElement {

  @track jobs = [];
  isLoading = false;
  hasError = false;

    @wire(getDataflowJobs, {
    licenseType: "EinsteinAnalytics",
    status: "Success",
    jobTypes: "FileUpload",
    pageSize: 3
  })
  onGetDataflowJobs({ data, error }) {
    if (error) {
      console.log("getDataflowJobs ERROR:", error);
      this.hasError = true;
    } else if (data) {
      console.log("getDataflowJobs DATA: ", data);
      console.log("Dataflow Jobs: ", data.dataflowJobs);
      console.log("Dataflow Jobs Count: "+ data);
      this.jobs = data.dataflowJobs.map((job) => ({
        id: job.id,
        dataflowName: job.label,
        status: job.status,
        startTime: new Date(job.executedDate).toLocaleString(),
        waitTime: this.formatSecondsToTime(job.waitTime), 
        duration: this.formatSecondsToTime(job.duration),    
      }));
      this.hasError = false;
    }
  }

  formatSecondsToTime(seconds) {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = seconds % 60;

  const padded = (num) => String(num).padStart(2, '0');

  return `${padded(hrs)}:${padded(mins)}:${padded(secs)}`;
}
}