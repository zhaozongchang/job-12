class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :descroy]
  before_action :validate_search_key, only: [:search]
  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC')
            else
              Job.published.recent
            end
          end

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "该职位以下架"
      redirect_to root_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
    redirect_to jobs_path
  else
    render :new
   end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
    redirect_to jobs_path
  else
    render :edit
   end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, :alert => "删除成功"
  end

  def information
    @jobs = Job.published.where(:category_id => 1).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def marketing
    @jobs = Job.published.where(:category_id => 2).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def education
    @jobs =  Job.published.where(:category_id => 3).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def medical
    @jobs = Job.published.where(:category_id => 4).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def operation
    @jobs = Job.published.where(:category_id => 5).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def page_design
    @jobs = Job.published.where(:category_id => 6).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def manage
    @jobs = Job.published.where(:category_id => 7).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def administrative
    @jobs = Job.published.where(:category_id => 8).recent.paginate(:page => params[:page], :per_page => 5)
  end

  def search
    if @query_string.present?
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_description_cont => query_string } #搜索匹配title和description，可以加其他关键词匹配
  end

  private

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
