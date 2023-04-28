class ReportsController < ApplicationController
  def create
    authorization = current_user[:token]
    @report = ReportService.new.fetch_report(authorization, report_params)

    if @report
      redirect_to "/reports", notice: @report["message"]
    else
      redirect_to "/reports", alert: "Error please try again!"
    end
  end

  private

  def report_params
    {start_date: params[:start_date], end_date: params[:end_date]}
  end
end
