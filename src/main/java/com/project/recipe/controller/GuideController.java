package com.project.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.recipe.common.Fileupload;
import com.project.recipe.dao.GuideDAO;
import com.project.recipe.dto.GuideDTO;
import com.project.recipe.dto.GuideStepDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GuideController {

    private final GuideDAO guideDao;
    private final Fileupload fileupload;

    @GetMapping("/guide_list.do")
    public String guideList(){
        return "guide/guide_list";
    }

    //전체보기,보관법,손질법...
    @ResponseBody
    @GetMapping("/guide_tab.do")
    public List<GuideDTO> guideTab(String tab) {

        Map<String, Object> map = new HashMap<>();
        map.put("tab", tab);

        return guideDao.guideTab(map);
    }

    //상세페이지
    @GetMapping("/guide_detail.do")
    public String detail(int guide_id, Model model) {

        GuideDTO guide = guideDao.Detail(guide_id);
        model.addAttribute("guide", guide);

        List<GuideStepDTO> stepList = guideDao.stepList(guide_id);
        model.addAttribute("stepList", stepList);

        return "guide/guide_detail";
    }

    // 가이드 작성 페이지
    @GetMapping("/guide_add.do")
    public String guideAdd() {

        return "guide/guide_add";
    }

    // 가이드 작성 처리
    @PostMapping("/guide_add.do")
    public String guideAddProcess(
            GuideDTO guide,
            @RequestParam("mainImage") MultipartFile mainImage,
            @RequestParam("step_content") List<String> stepContents,
            @RequestParam("step_image") List<MultipartFile> stepImages) throws Exception {

        String mainFileName = fileupload.saveFile(mainImage, "guide");

        guide.setImage(mainFileName);

        guideDao.guideInsert(guide);

        // useGeneratedKeys로 생성된 guide_id
        long guideId = guide.getGuide_id();

        // guide_step 등록

        for (int i = 0; i < stepContents.size(); i++) {

            GuideStepDTO step = new GuideStepDTO();

            step.setGuide_id(guideId);
            step.setStep_num(i + 1);
            step.setStep_content(stepContents.get(i));

            // 단계 이미지가 있는 경우
            if (i < stepImages.size()
                    && !stepImages.get(i).isEmpty()) {

                String stepFileName = fileupload.saveFile(stepImages.get(i), "guide");

                step.setStep_image(stepFileName);
            }

            guideDao.guideStepInsert(step);
        }

        return "redirect:/guide_detail.do?guide_id=" + guideId;
    }

    // 가이드 삭제
    @PostMapping("/guide_delete.do")
    public String guideDelete(@RequestParam("guide_id") long guide_id) {

        GuideDTO guide = guideDao.Detail((int) guide_id);

        List<GuideStepDTO> stepList = guideDao.stepList((int) guide_id);

        if (guide != null && guide.getImage() != null) {
            fileupload.deleteFile(
                    guide.getImage(),
                    "guide");
        }

        if (stepList != null) {

            for (GuideStepDTO step : stepList) {

                if (step.getStep_image() != null) {

                    fileupload.deleteFile(
                            step.getStep_image(),
                            "guide");
                }

            }

        }

        guideDao.guideStepDelete(guide_id);

        guideDao.guideDelete(guide_id);

        return "redirect:/guide_list.do";
    }

    // 가이드 수정 페이지
    @GetMapping("/guide_update.do")
    public String guideUpdate(
            @RequestParam("guide_id") int guide_id,
            Model model) {

        GuideDTO guide = guideDao.Detail(guide_id);

        List<GuideStepDTO> stepList = guideDao.stepList(guide_id);

        model.addAttribute("guide", guide);
        model.addAttribute("stepList", stepList);

        return "guide/guide_update";
    }

    // 가이드 수정 처리
    @PostMapping("/guide_update.do")
    public String guideUpdateProcess(
            GuideDTO guide,

            @RequestParam(value = "mainImage", required = false) MultipartFile mainImage,

            @RequestParam("step_id") List<Long> stepIds,

            @RequestParam("step_content") List<String> stepContents,

            @RequestParam("existing_step_image") List<String> existingStepImages,

            @RequestParam("step_image") List<MultipartFile> stepImages,

            @RequestParam(value = "delete_step_id", required = false) List<Long> deleteStepIds

    ) throws Exception {

        GuideDTO oldGuide = guideDao.Detail(
                (int) guide.getGuide_id());

        if (mainImage != null && !mainImage.isEmpty()) {

            if (oldGuide.getImage() != null
                    && !oldGuide.getImage().isEmpty()) {

                fileupload.deleteFile(
                        oldGuide.getImage(),
                        "guide");
            }

            String mainFileName = fileupload.saveFile(
                    mainImage,
                    "guide");

            guide.setImage(mainFileName);

        } else {

            guide.setImage(
                    oldGuide.getImage());
        }


        guideDao.guideUpdate(guide);

        if (deleteStepIds != null) {

            for (Long stepId : deleteStepIds) {

                GuideStepDTO deleteStep = guideDao.guideStepDetail(stepId);

                if (deleteStep != null
                        && deleteStep.getStep_image() != null
                        && !deleteStep.getStep_image().isEmpty()) {

                    fileupload.deleteFile(
                            deleteStep.getStep_image(),
                            "guide");
                }

                guideDao.guideStepDeleteOne(stepId);
            }
        }

        for (int i = 0; i < stepContents.size(); i++) {

     
            Long stepId = stepIds.get(i);

            if (stepId != null
                    && stepId > 0
                    && deleteStepIds != null
                    && deleteStepIds.contains(stepId)) {

                continue;
            }

            GuideStepDTO step = new GuideStepDTO();

            step.setGuide_id(
                    guide.getGuide_id());

            step.setStep_num(
                    i + 1);

            step.setStep_content(
                    stepContents.get(i));

            String stepImage = existingStepImages.get(i);

            if (i < stepImages.size()
                    && stepImages.get(i) != null
                    && !stepImages.get(i).isEmpty()) {

                if (stepImage != null
                        && !stepImage.isEmpty()) {

                    fileupload.deleteFile(
                            stepImage,
                            "guide");
                }

                stepImage = fileupload.saveFile(
                        stepImages.get(i),
                        "guide");
            }

            step.setStep_image(stepImage);

            if (stepId != null && stepId > 0) {

                step.setStep_id(stepId);

                guideDao.guideStepUpdate(step);

            }

            else {

                guideDao.guideStepInsert(step);

            }

        }

        return "redirect:/guide_detail.do?guide_id="
                + guide.getGuide_id();
    }
}
